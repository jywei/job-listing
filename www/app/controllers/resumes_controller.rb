class ResumesController < ApplicationController
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
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def education
  end

  def getEdu
    @schools = School.all.includes(:university, :degree_level)
    @language = Language.all

    bigschool = Array.new
    @schools.each do |sc|
      school = Array.new
      school.push(sc.university.name, sc.start_day, sc.end_day, sc.degree_level.name, sc.field_of_study, sc.grade, sc.id)
      bigschool.push(school)
    end

    biglan = Array.new
    @language.each do |lan|
      language = Array.new
      language.push(lan.name, lan.proficiency.name, lan.id)
      biglan.push(language)
    end

    respond_to do |format|
      format.html { render :json => { :school => bigschool, :language => biglan } }
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
        language.push(@language.name, @language.proficiency_id, @language.id)
        format.json { render :json => { :language => language } }
      else
        format.json { render :json => { :error => "", :language => @language.errors.full_messages } }
      end
    end
  end

  def deleEdu
    if params[:name] == 'Sch'
      boolean = School.find(params[:id]).delete
    elsif params[:name] == 'Lan'
      boolean = Language.find(params[:id]).delete
    end

    respond_to do |format|
      format.json { render :json => !boolean }
    end
  end

  def edit
    # @resime = Resume.find(:id)
  end

  def update
  end

  private

    def resume_params
      params.require(:resume).permit(:firstname,
                                     :lastname,
                                     :phone,
                                     :location_id,
                                     :cover)
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
      params.require(:language).permit(:name,
                                       :proficiency_id)
    end
end
