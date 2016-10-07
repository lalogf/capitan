# == Schema Information
#
# Table name: profiles
#
#  id                            :integer          not null, primary key
#  user_id                       :integer
#  name                          :string(255)
#  lastname                      :string(255)
#  biography                     :string(255)
#  dni                           :string(255)
#  district_id                   :integer
#  phone1                        :string(255)
#  phone2                        :string(255)
#  facebook_link                 :string(255)
#  major                         :string(255)
#  school                        :string(255)
#  semesters_left                :integer
#  reasons_school_not_done       :integer
#  job_status                    :integer
#  work_for                      :integer
#  work_for_details              :string(255)
#  job_title                     :string(255)
#  job_payroll                   :boolean
#  job_type                      :integer
#  job_salary_id                 :integer
#  family_income_id              :integer
#  relatives                     :integer
#  childs                        :boolean
#  tech_savy                     :integer
#  tech_related_activities       :integer
#  other_tech_related_activities :string(255)
#  computer_at_home              :boolean
#  internet_access               :boolean
#  smartphone                    :boolean
#  computer_use                  :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :district
  belongs_to :job_salary
  belongs_to :family_income
end
