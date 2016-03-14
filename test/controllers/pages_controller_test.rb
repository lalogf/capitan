# == Schema Information
#
# Table name: pages
#
#  id                         :integer          not null, primary key
#  title                      :string(255)
#  unit_id                    :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  page_type                  :string(255)
#  sequence                   :integer
#  instructions               :text(65535)
#  html                       :text(65535)
#  initial_state              :text(65535)
#  solution                   :text(65535)
#  success_message            :string(255)
#  videotip                   :string(255)
#  points                     :integer
#  question_points            :integer
#  selfLearning               :boolean          default(FALSE)
#  load_from_previous         :boolean
#  auto_corrector             :boolean          default(FALSE)
#  grade                      :integer          default(0)
#  slide_url                  :string(255)
#  document_file_name         :string(255)
#  document_content_type      :string(255)
#  document_file_size         :integer
#  document_updated_at        :datetime
#  excercise_instructions     :text(65535)
#  show_solution              :boolean
#  video_solution             :string(255)
#  solution_file_file_name    :string(255)
#  solution_file_content_type :string(255)
#  solution_file_file_size    :integer
#  solution_file_updated_at   :datetime
#  draft_comments_count       :integer          default(0)
#  published_comments_count   :integer          default(0)
#  deleted_comments_count     :integer          default(0)
#  solution_visibility        :integer
#

require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post :create, page: { title: @page.title, unit_id: @page.unit_id }
    end

    assert_redirected_to page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page
    assert_response :success
  end

  test "should update page" do
    patch :update, id: @page, page: { title: @page.title, unit_id: @page.unit_id }
    assert_redirected_to page_path(assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page
    end

    assert_redirected_to pages_path
  end
end
