# == Schema Information
#
# Table name: sprint_pages
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  page_id    :integer
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SprintPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
