namespace :capitan do
  task :cleandb => :environment do
      Answer.destroy_all
      User.destroy_all
  end
  
  task :import_users => :environment do
      import_file = "#{Rails.root}/public/seed_data/import-data.xlsx"
      User.import(import_file)
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