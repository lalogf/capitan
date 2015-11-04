# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  user_id    :integer
#  result     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
