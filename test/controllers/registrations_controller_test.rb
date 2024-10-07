require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get registrations_url, as: :json
    assert_response :success
  end

  test "should create registration" do
    assert_difference("Registration.count") do
      post registrations_url, params: { registration: { participant_email: @registration.participant_email, participant_name: @registration.participant_name } }, as: :json
    end

    assert_response :created
  end

  test "should show registration" do
    get registration_url(@registration), as: :json
    assert_response :success
  end

  test "should update registration" do
    patch registration_url(@registration), params: { registration: { participant_email: @registration.participant_email, participant_name: @registration.participant_name } }, as: :json
    assert_response :success
  end

  test "should destroy registration" do
    assert_difference("Registration.count", -1) do
      delete registration_url(@registration), as: :json
    end

    assert_response :no_content
  end
end
