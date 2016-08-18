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

    bigschool = Array.new
    @schools.each do |sc|
      school = Array.new
      school.push(sc.university.name, sc.start_day, sc.end_day, sc.degree_level.name, sc.field_of_study, sc.grade, sc.id)
      bigschool.push(school)
    end

    respond_to do |format|
<<<<<<< HEAD
      format.html { render :json => { :school => bigschool } }
=======
      format.html { render json: { school: @schools } }
>>>>>>> 6efb9bb6c4a8937c18e1dbaad3835b51a4ed5c3b
    end
  end

  def addSch
    # binding.pry
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        school = Array.new
        # binding.pry
        school.push(@school.university.name, @school.start_day, @school.end_day, @school.degree_level.name, @school.field_of_study, @school.grade)
        format.json { render :json => { :school => school } }
      else
        format.json { render :json => { :error => "", :school => @school.errors.full_messages } }
      end
    end
  end

  def deleEdu
    if params[:name] == 'Sch'
      boolean = School.find(params[:id]).delete
    end

    respond_to do |format|
<<<<<<< HEAD
      format.json { render :json => boolean }
=======
      format.html { render json: { school: @school } }
>>>>>>> 6efb9bb6c4a8937c18e1dbaad3835b51a4ed5c3b
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
end
