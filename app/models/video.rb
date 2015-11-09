# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  youtube    :string(255)
#

class Video < ActiveRecord::Base

 has_and_belongs_to_many :pages
    
end
