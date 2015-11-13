namespace :import do
  task :users => :environment do
      import_file = "#{Rails.root}/public/seed_data/import-data.xlsx"
      User.import(import_file)
  end
end 