require "#{Rails.root}/app/helpers/text_helper"
include TextHelper

task :send_reminders => :environment do
  send_reminders
end