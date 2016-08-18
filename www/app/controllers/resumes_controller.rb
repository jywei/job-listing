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
    @schools = School.all

    respond_to do |format|
      format.html { render json: { school: @schools } }
    end
  end

  def addSch
    binding.pry
    @school = DegreeLevel.find(params[:degree_level_id]).schools.create!( name: params[:name],
                              start_day: params[:start_day],
                              end_day: params[:end_day],
                              degree_level_id: params[:degree_level_id].to_i,
                              field_of_study: params[:field_of_study],
                              grade: params[:grade])
    respond_to do |format|
      format.html { render json: { school: @school } }
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

    # def school_params
    #   params.require(:school).permit(:name,
    #                                  :start_day,
    #                                  :end_day,
    #                                  :degree_level_id,
    #                                  :field_of_study,
    #                                  :grade)
    # end
end
