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
end
