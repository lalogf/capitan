# == Schema Information
#
# Table name: page_visibilities
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  branch_id  :integer
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PageVisibilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
