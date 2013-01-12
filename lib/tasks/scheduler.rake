desc "This task is called by the Heroku scheduler add-on"
include TextHelper

task :send_reminders => :environment do
  TextHelper.send_reminders
end