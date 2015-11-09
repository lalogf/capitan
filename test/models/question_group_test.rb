# == Schema Information
#
# Table name: question_groups
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  question_id :integer
#  sequence    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class QuestionGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
