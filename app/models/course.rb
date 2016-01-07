# == Schema Information
#
# Table name: courses
#
#  id                            :integer          not null, primary key
#  name                          :string(255)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  description                   :text(65535)
#  avatar_file_name              :string(255)
#  avatar_content_type           :string(255)
#  avatar_file_size              :integer
#  avatar_updated_at             :datetime
#  color                         :string(255)
#  background_image_file_name    :string(255)
#  background_image_content_type :string(255)
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#  code                          :string(255)
#

class Course < ActiveRecord::Base
    
    has_attached_file :avatar, 
                      :styles => { :thumb => "110x110>", :medium => "220x220>" },
                      :url => "/system/:class/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"
                      
    has_attached_file :background_image,
                      :styles => { :big => "1600x400>" },
                      :url => "/system/:class/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"
                      
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/    
    validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/
    
    validates :name, presence: true
    
    has_many :units, :dependent => :destroy
    
    def get_course_sum_points
        points = 0
        Page.get_editor_pages_for_course(self.id).each do |page|
            points += page.points if page.points != nil
        end
        Page.get_question_pages_for_course(self.id).each do |page|
             points += page.question_points * page.question_groups.count if page.question_points != nil
        end
        return points
    end
end
