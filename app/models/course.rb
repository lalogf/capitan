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
end
