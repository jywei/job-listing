class ResumesController < ApplicationController
  def show
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
  end

  def edit
  end

  def update
  end

  private

    def resume_params
      params.require(:resume).permit(:firstname,
                                     :lastname,
                                     :phone,
                                     :location_id)
    end
end
