class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :pages, :dependent => :destroy
  
  def has_pages(branch_id)
    query = "select count(p.id) 
             from pages p
             join lessons l on p.lesson_id = l.id
             join units u on l.unit_id = u.id
             join page_visibilities pv on p.id = pv.page_id
             where u.id = #{self.id} and branch_id = #{branch_id} and pv.status = 1"    
  end
  
  def visible_pages(branch_id)
    return self.pages.visible_page(branch_id).order(:sequence)
  end
  
  def total_points
    return self.pages.sum(:points)
  end
    
end
