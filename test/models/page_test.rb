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
#  video_solution             :string(255)
#  solution_file_file_name    :string(255)
#  solution_file_content_type :string(255)
#  solution_file_file_size    :integer
#  solution_file_updated_at   :datetime
#  draft_comments_count       :integer          default(0)
#  published_comments_count   :integer          default(0)
#  deleted_comments_count     :integer          default(0)
#  solution_visibility        :string(255)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
