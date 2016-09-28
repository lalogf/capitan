namespace :capitan do
  task :cleandb => :environment do
      Answer.destroy_all
      User.destroy_all
  end

  task :blank_password => :environment do
    User.all.each do |user|
      p "Cambiando password a admin, user= #{user.code}"
      user.password = "admin"
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
    User.import_scores(import_file, ENV['LESSON_ID'])
  end

  task :import_soft_skills_scores => :environment do |t, args|
    import_file = "#{Rails.root}/public/seed_data/#{ENV['FILE_NAME']}"
    User.import_soft_skills_scores(import_file, ENV['SPRINT_ID'])
  end
end
