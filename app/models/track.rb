# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string(255)
#  duration    :integer
#  syllabus    :string(255)
#

class Track < ActiveRecord::Base
  has_many :courses

  def duration
    query = "select sum(duration) from units u join courses c on u.course_id = c.id join tracks t on c.track_id = t.id where t.id = #{self.id}"
    ActiveRecord::Base.connection.execute(query).first[0]
  end
end
