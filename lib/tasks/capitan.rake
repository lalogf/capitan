namespace :capitan do
  task :cleandb => :environment do
      Answer.destroy_all
      User.destroy_all
  end
  
  task :import_users => :environment do
      import_file = "#{Rails.root}/public/seed_data/import-data.xlsx"
      User.import(import_file)
  end
  
end 