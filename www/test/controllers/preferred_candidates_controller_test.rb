require 'test_helper'

class PreferredCandidatesControllerTest < ActionController::TestCase
  setup do
    @preferred_candidate = preferred_candidates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preferred_candidates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preferred_candidate" do
    assert_difference('PreferredCandidate.count') do
      post :create, preferred_candidate: { career_level_id: @preferred_candidate.career_level_id, contract_type_id: @preferred_candidate.contract_type_id, country_id: @preferred_candidate.country_id, degree_level_id: @preferred_candidate.degree_level_id, job_category_id: @preferred_candidate.job_category_id, language_id: @preferred_candidate.language_id, location_id: @preferred_candidate.location_id, related_experience_id: @preferred_candidate.related_experience_id }
    end

    assert_redirected_to preferred_candidate_path(assigns(:preferred_candidate))
  end

  test "should show preferred_candidate" do
    get :show, id: @preferred_candidate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preferred_candidate
    assert_response :success
  end

  test "should update preferred_candidate" do
    patch :update, id: @preferred_candidate, preferred_candidate: { career_level_id: @preferred_candidate.career_level_id, contract_type_id: @preferred_candidate.contract_type_id, country_id: @preferred_candidate.country_id, degree_level_id: @preferred_candidate.degree_level_id, job_category_id: @preferred_candidate.job_category_id, language_id: @preferred_candidate.language_id, location_id: @preferred_candidate.location_id, related_experience_id: @preferred_candidate.related_experience_id }
    assert_redirected_to preferred_candidate_path(assigns(:preferred_candidate))
  end

  test "should destroy preferred_candidate" do
    assert_difference('PreferredCandidate.count', -1) do
      delete :destroy, id: @preferred_candidate
    end

    assert_redirected_to preferred_candidates_path
  end
end
