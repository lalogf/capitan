# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  unit_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  page_type       :string(255)
#  sequence        :integer
#  instructions    :text(65535)
#  html            :text(65535)
#  initial_state   :text(65535)
#  solution        :text(65535)
#  success_message :string(255)
#  videotip        :string(255)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
