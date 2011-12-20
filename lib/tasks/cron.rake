desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Date.today.wday == 0 # Runs every sunday
    Rake::Task['dev_dv:seed'].invoke(true)
  end
end
