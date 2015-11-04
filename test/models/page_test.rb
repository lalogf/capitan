# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  unit_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  page_type    :string(255)
#  sequence     :integer
#  instructions :string(255)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
