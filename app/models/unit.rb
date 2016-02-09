# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sequence    :integer          default(0)
#

class Unit < ActiveRecord::Base
  
  belongs_to :course
  has_many :pages, :dependent => :destroy
  
  def has_pages(branch_id)
    query = "select count(*) 
             from pages p
             join units u on p.unit_id = u.id
             join page_visibilities pv on p.id = pv.page_id
             where u.id = #{self.id} and branch_id = #{branch_id} and pv.status = 1"    
  end
  
  def visible_pages(branch_id)
    return self.pages.visible_page(branch_id).order(:sequence)
  end
  
end
