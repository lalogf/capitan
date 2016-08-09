namespace :capitan do
  task :cleandb => :environment do
      Answer.destroy_all
      User.destroy_all
  end
  
  task :blank_password => :environment do
    User.all.each do |user|
      p "Cambiando password a admin, user= #{user.code}"
      user.password = "admin"
      user.password_confirmation  = "admin"
      user.save!
    end
  end
  
  task :import_users, [:file_name] => :environment do |t, args|
      import_file = "#{Rails.root}/public/seed_data/#{args[:file_name]}"
      User.import(import_file)
  end
  
  task :import_code_review, [:file_name] => :environment do |t, args|
    import_file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
    Review.import(import_file, ENV['LESSON_ID'])
  end
  
  task :import_scores => :environment do |t, args|
    import_file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
    User.import_score(import_file, ENV['LESSON_ID'])
  end
  
  # Borrar ASAP!!
  task :import_sprint_scores => :environment do |t, args|
    import_file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
    User.import_sprint_scores(import_file)
  end
  
  task :rebuild_grades => :environment do
    users = User.all
    users.each do |user|
      p "Recalculando notas para #{user.code}"
      user.answers.each do |answer|
        case answer.page.page_type
          when "editor"
            if answer.result != nil
              answer.points = answer.page.points
            else
              answer.points = 0
            end
          when "questions"
            answer.points = 0
            if answer.result != nil
              parts = answer.result.split(";")
              for i in 1...parts.length do
                option_id = parts[i].split("|")[1]
                if (Option.find(option_id).correct?)
                  answer.points = answer.points + answer.page.question_points
                end
              end
            end
        end
        p "Pregunta: id #{answer.id},tipo: #{answer.page.page_type}, puntos: #{answer.points}" if ["editor","questions"].include?(answer.page.page_type)
        answer.save
      end
    end
  end
end 