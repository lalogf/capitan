class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :lastname
      t.string :biography
      t.string :dni
      t.references :district, index: true, foreign_key: true
      t.string :phone1
      t.string :phone2
      t.string :facebook_link
      t.string :major
      t.string :school
      t.integer :semesters_left
      t.integer :reasons_school_not_done
      t.integer :job_status
      t.integer :work_for
      t.string :work_for_details
      t.string :job_title
      t.boolean :job_payroll
      t.integer :job_type
      t.references :job_salary, index: true, foreign_key: true
      t.references :family_income, index: true, foreign_key: true
      t.integer :relatives
      t.boolean :childs
      t.integer :tech_savy
      t.integer :tech_related_activities
      t.string :other_tech_related_activities
      t.boolean :computer_at_home
      t.boolean :internet_access
      t.boolean :smartphone
      t.integer :computer_use

      t.timestamps null: false
    end
  end
end
