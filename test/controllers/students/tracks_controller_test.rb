require 'test_helper'

class Students::TracksControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get performance" do
    get :performance
    assert_response :success
  end

  test "should get tracks" do
    get :tracks
    assert_response :success
  end

  test "should get resources" do
    get :resources
    assert_response :success
  end

end
