class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  before_action :set_reserved_resumes, only: [:unfollow_job]

  def index
    @filterrific = initialize_filterrific(
      Resume.all,
      params[:filterrific],
      default_filter_params: {},
              
    ) or return
    @resumes = @filterrific.find.includes(:desired_jobs_salary, :location, :employment_status, :experiences).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @resume = Resume.new
    @resume.user_id = current_user.id
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user.id
    if @resume.save
      current_user.add_role :seeker
      redirect_to resumes_education_path, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @resume.update(resume_params)
      flash[:success] = "Update resume successfully"
      render :edit
    else
      render :edit
    end
  end

  def education
  end

  def getEdu
    @schools = School.where(resume_id: current_user.resume.id).includes(:university, :degree_level)
    @languages = Language.where(resume_id: current_user.resume.id)
    @skills = Skill.where(resume_id: current_user.resume.id)

    bigschool = Array.new
    @schools.each do |sc|
      school = Array.new
      school.push(sc.university.name, sc.start_day, sc.end_day, sc.degree_level.name, sc.field_of_study, sc.grade, sc.id)
      bigschool.push(school)
    end

    biglan = Array.new
    @languages.each do |lan|
      language = Array.new
      language.push(lan.language_skill.name, lan.proficiency.name, lan.id)
      biglan.push(language)
    end

    respond_to do |format|
      format.html { render :json => { :school => bigschool, :language => biglan, :skill => @skills } }
    end
  end

  def addSch
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        resume_id = current_user.resume.id
        @school.update_attributes(resume_id: resume_id)
        school = Array.new
        school.push(@school.university.name, @school.start_day, @school.end_day, @school.degree_level.name, @school.field_of_study, @school.grade, @school.id)
        format.json { render :json => { :school => school } }
      else
        format.json { render :json => { :error => "", :school => @school.errors.full_messages } }
      end
    end
  end

  def addLan
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        resume_id = current_user.resume.id
        @language.update_attributes(resume_id: resume_id)
        language = Array.new
        language.push(@language.language_skill.name, @language.proficiency.name, @language.id)
        format.json { render :json => { :language => language } }
      else
        format.json { render :json => { :error => "", :language => @language.errors.full_messages } }
      end
    end
  end

  def addSki
    @skill = Skill.new(skill_params)

    respond_to do |format|
      if @skill.save
        resume_id = current_user.resume.id
        @skill.update_attributes(resume_id: resume_id)
        format.json { render :json => { :skill => @skill } }
      else
        format.json { render :json => { :error => "", :skill => @skill.errors.full_messages } }
      end
    end
  end

  def deleEdu
    if params[:name] == 'Sch'
      boolean = School.find(params[:id]).delete
    elsif params[:name] == 'Lan'
      boolean = Language.find(params[:id]).delete
    elsif params[:name] == 'Ski'
      boolean = Skill.find(params[:id]).delete
    end

    respond_to do |format|
      format.json { render :json => !boolean }
    end
  end

  def getExp
    @experiences = Experience.where(resume_id: current_user.resume.id)
    @djs = DesiredJobsSalary.where(resume_id: current_user.resume.id)
    @djr = DesiredJobsRole.where(resume_id: current_user.resume.id)
    @dji = DesiredJobsIndustry.where(resume_id: current_user.resume.id)

    bigexp = Array.new
    @experiences.each do |exp|
      experience = Array.new
      experience.push(exp.job_title, exp.company_name, exp.start_day, exp.end_day, exp.country.name, exp.industry.name, exp.contract_type.name, exp.activities, exp.id)
      bigexp.push(experience)
    end

    bigdjr = Array.new
    @djr.each do |djr|
      desired_job_role = Array.new
      desired_job_role.push(djr.category.name, djr.id)
      bigdjr.push(desired_job_role)
    end
    
    bigdji = Array.new
    @dji.each do |dji|
      desired_job_industry = Array.new
      desired_job_industry.push(dji.industry.name, dji.id)
      bigdji.push(desired_job_industry)
    end

    respond_to do |format|
      format.json { render :json => { :experience => bigexp, :djs => @djs, :djr => bigdjr, :dji => bigdji } }
    end
  end

  def addExp
    @experience = Experience.new(experience_params)

    respond_to do |format|
      if @experience.save
        resume_id = current_user.resume.id
        @experience.update_attributes(resume_id: resume_id)
        experience = Array.new
        experience.push(@experience.job_title, @experience.company_name, @experience.start_day, @experience.end_day, @experience.country.name, @experience.industry.name, @experience.contract_type.name, @experience.activities, @experience.id)
        format.json { render :json => { :experience => experience } }
      else
        format.json { render :json => { :error => "", :experience => @experience.errors.full_messages } }
      end
    end
  end

  def addDJS
    unless current_user.resume.desired_jobs_salary.present?
      @djs = DesiredJobsSalary.new(djs_params)

      respond_to do |format|
        if @djs.save
          resume_id = current_user.resume.id
          @djs.update_attributes(resume_id: resume_id)
          format.json { render :json => { :djs => @djs } }
        else
          format.json { render :json => { :error => "", :djs => @djs.errors.full_messages } }
        end
      end
    end
  end

  def addDJR
    @djr = DesiredJobsRole.new(djr_params)

    respond_to do |format|
      if @djr.save
        resume_id = current_user.resume.id
        @djr.update_attributes(resume_id: resume_id)
        djr = Array.new
        djr.push(@djr.category.name, @djr.id)
        format.json { render :json => { :djr => djr } }
      else
        format.json { render :json => { :error => "", :djr => @djr.errors.full_messages } }
      end
    end
  end

  def addDJI
    @dji = DesiredJobsIndustry.new(dji_params)

    respond_to do |format|
      if @dji.save
        resume_id = current_user.resume.id
        @dji.update_attributes(resume_id: resume_id)
        dji = Array.new
        dji.push(@dji.industry.name, @dji.id)
        format.json { render :json => { :dji => dji } }
      else
        format.json { render :json => { :error => "", :dji => @dji.errors.full_messages } }
      end
    end
  end

  def deleExp
    if params[:name] == 'Exp'
      boolean = Experience.find(params[:id]).delete
    elsif params[:name] == 'Djs'
      boolean = DesiredJobsSalary.find(params[:id]).delete
    elsif params[:name] == 'Djr'
      boolean = DesiredJobsRole.find(params[:id]).delete
    elsif params[:name] == 'Dji'
      boolean = DesiredJobsIndustry.find(params[:id]).delete
    end

    respond_to do |format|
      format.json { render :json => !boolean }
    end
  end

  def favorite_resume
    @reserved_resume = ReservedResume.create(tracking_company_id: current_user.company.id, favorite_resume_id: params[:id])
    render json: @reserved_resume
  end

  def unfollow_resume
    @reserved_resume = current_user.company.reserved_resumes.find_by(favorite_resume_id: params[:id]).destroy
    render json: @reserved_resume
  end

  private

    def set_resume
      @resume = Resume.find(params[:id])
    end

    def set_reserved_resumes
      @reserved_resumes = current_user.company.reserved_resumes
    end

    def resume_params
      params.require(:resume).permit(:firstname,
                                     :lastname,
                                     :phone,
                                     :location_id,
                                     :cover,
                                     :birth)
    end

    def school_params
      params.require(:school).permit(:university_id,
                                     :start_day,
                                     :end_day,
                                     :degree_level_id,
                                     :field_of_study,
                                     :grade)
    end

    def language_params
      params.require(:language).permit(:language_skill_id,
                                       :proficiency_id)
    end

    def skill_params
      params.require(:skill).permit(:name)
    end

    def experience_params
      params.require(:experience).permit(:job_title,
                                         :company_name,
                                         :start_day,
                                         :end_day,
                                         :country_id,
                                         :industry_id,
                                         :contract_type_id,
                                         :activities,
                                         :resume_id)
    end

    def djs_params
      params.require(:djs).permit(:salary)
    end

    def djr_params
      params.require(:djr).permit(:category_id)
    end

    def dji_params
      params.require(:dji).permit(:industry_id)
    end
end
