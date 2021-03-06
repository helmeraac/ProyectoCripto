# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, :at => '08:00 pm' do
  runner 'AppointmentRemindersJob.perform_later(Appointment.find_to_reminder(Time.now+1.days).collect {|a| a.user},Appointment.find_to_reminder(Time.now+1.days).collect {|a| a.date.to_i},Appointment.find_to_reminder(Time.now+1.days).collect {|a| a.lab.city.to_s},Appointment.find_to_reminder(Time.now+1.days).collect {|a| a.lab.address.to_s},Appointment.find_to_reminder(Time.now+1.days).collect {|a| a.lab.phone.to_s})'
end