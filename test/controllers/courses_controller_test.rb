# == Schema Information
#
# Table name: courses
#
#  id                            :integer          not null, primary key
#  name                          :string(255)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  description                   :text(65535)
#  avatar_file_name              :string(255)
#  avatar_content_type           :string(255)
#  avatar_file_size              :integer
#  avatar_updated_at             :datetime
#  color                         :string(255)
#  background_image_file_name    :string(255)
#  background_image_content_type :string(255)
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  code                          :string(255)
#

require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { name: @course.name }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { name: @course.name }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
