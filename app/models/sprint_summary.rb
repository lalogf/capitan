# == Schema Information
#
# Table name: sprint_summaries
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  sprint_id              :integer
#  total_technical_skills :float(24)
#  total_soft_skills      :float(24)
#  max_technical_skills   :float(24)
#  max_soft_skills        :float(24)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class SprintSummary < ActiveRecord::Base
end
