class PreferredCandidatesController < ApplicationController
  before_action :set_preferred_candidate, only: [:show, :edit, :update, :destroy]

  # GET /preferred_candidates
  # GET /preferred_candidates.json
  def index
    @preferred_candidates = PreferredCandidate.all
  end

  # GET /preferred_candidates/1
  # GET /preferred_candidates/1.json
  def show
  end

  # GET /preferred_candidates/new
  def new
    @preferred_candidate = PreferredCandidate.new
    @preferred_candidate.languages.new
    @job = @preferred_candidate.job
  end

  # GET /preferred_candidates/1/edit
  def edit
  end

  # POST /preferred_candidates
  # POST /preferred_candidates.json
  def create
    @preferred_candidate = PreferredCandidate.new(preferred_candidate_params)

    respond_to do |format|
      if @preferred_candidate.save
        format.html { redirect_to request.referer, notice: 'Preferred candidate was successfully created.' }
        format.json { render :show, status: :created, location: @preferred_candidate }
      else
        format.html { render :new }
        format.json { render json: @preferred_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferred_candidates/1
  # PATCH/PUT /preferred_candidates/1.json
  def update
    respond_to do |format|
      if @preferred_candidate.update(preferred_candidate_params)
        format.html { redirect_to request.referer, notice: 'Preferred candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @preferred_candidate }
      else
        format.html { render :edit }
        format.json { render json: @preferred_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferred_candidates/1
  # DELETE /preferred_candidates/1.json
  def destroy
    @preferred_candidate.destroy
    respond_to do |format|
      format.html { redirect_to preferred_candidates_url, notice: 'Preferred candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preferred_candidate
      @preferred_candidate = PreferredCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preferred_candidate_params
      params.require(:preferred_candidate).permit(:job_id, :location_id, :country_id, :contract_type_id, :category_id, :career_level_id, :degree_level_id, :related_experience_id, languages_attributes: [:id, :language_skill_id, :proficiency_id, :_destroy, language_skill: [], proficiency: [] ] )
    end
end
