class AppointmentRemindersJob < ApplicationJob

  def perform(users,appointments_dates)
    appointments_dates=appointments_dates.collect {|ad| Time.at(ad)}
    users.each_with_index {|user,i| UserMailer.appointment_reminder_mail(user,appointments_dates[i]).deliver}
    # Do something later
  end
end
