namespace :capitan do

  desc "Change users password to capitan so we can use any account in development, don't use it in production!!"
  task :blank_password => :environment do
    User.all.each do |user|
      p "Scrambling password for user #{user.code}"
      user.password = "capitan"
      user.save!
    end
  end

  desc "Import users into capitan"
  task :import_users => :environment do
    begin
      file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
      spreadsheet = Roo::Spreadsheet.open(file)

      header = spreadsheet.row(1)

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        user = User.find_or_initialize_by(code: row["code"])
        profile_attributes = Hash.new
        row.select { |key| key.include?("profile") }.map { |key,value| profile_attributes[key.sub("profile/","")] = value }
        row = row.delete_if { |key| key.include?("profile") }
        row["profile_attributes"] = profile_attributes
        user.update_attributes(row)
        if user.save(validate: false)
          p "#{user.code} updated"
        else
          p "Errors for #{user.code}: #{user.errors.full_messages}"
        end
      end
    rescue Exception => e
      p e.message
    end
  end

  desc "Import code reviews"
  task :import_code_review => :environment do
    begin
      import_file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
      Review.import(import_file, ENV['LESSON_ID'])
    rescue Exception => e
      p e.message
    end
  end

  desc "Import scores"
  task :import_scores => :environment do
    begin
      file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
      spreadsheet = Roo::Spreadsheet.open(file)

      header = spreadsheet.row(1)
      lesson = Lesson.find(ENV['LESSON_ID'])

      if lesson
        (2..spreadsheet.last_row).each do |i|
          row = spreadsheet.row(i)
          user = User.where(code: row[0]).first
          if user
            header.each_with_index do |h,index|
              if h != "code"
                page = Page.find_by_code(h)
                if page
                  subm = Submission.where(page_id: page.id, user_id: user.id)
                  if subm.count == 0
                    subm = Submission.new(page_id: page.id, user_id: user.id, points: row[index].to_f.round(2))
                  else
                    subm = subm.first
                    subm.points = row[index].to_f.round
                  end
                  p subm.save ? "Grade saved for user #{user.code}. Grade: #{row[index].to_f.round(2)}, Page: #{page.title}" : "User #{user.code} failed"
                else
                  p "Couldn't find a valid page for #{h} code"
                end
              end
            end
          else
            p "Couldn't find a valid user for #{row[0]} code"
          end
        end
      else
        p "Couldn't find a valid lesson ID"
      end
    rescue Exception => e
      p e.message
    end
  end

  task :import_soft_skills_scores => :environment do
    begin
      file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
      spreadsheet = Roo::Spreadsheet.open(file)

      header = spreadsheet.row(1)
      sprint = Sprint.find(ENV['SPRINT_ID'])

      if sprint
        (2..spreadsheet.last_row).each do |i|
          row = spreadsheet.row(i)
          user = User.where(code: row[0]).first
          if user
            header.each_with_index do |h,index|
              if h != "code"
                soft_skill = SoftSkill.find_by_name(h)
                if soft_skill != nil
                  subm = SoftSkillSubmission.where(user_id: user.id, sprint_id: sprint.id, soft_skill_id: soft_skill.id)
                  if subm.count == 0
                    subm = SoftSkillSubmission.new(user_id: user.id, sprint_id: sprint.id, soft_skill_id: soft_skill.id, points: row[index].to_f.round)
                  else
                    subm = subm.first
                    subm.points = row[index].to_f.round
                  end
                  if subm.save
                    p "Soft skill #{soft_skill.name} graded with #{row[index].to_f.round} for #{user.code}"
                  else
                    p "Adding Soft skill #{soft_skill.name} for #{user.code} failed"
                  end
                else
                  p "Couldn't find a valid Soft skill"
                end
              end
            end
          else
            p "Couldn't find #{row[0]} user"
          end
        end
      else
        p "Couldn't find a valid Sprint ID"
      end
    rescue Exception => e
      p e.message
    end
  end
end
