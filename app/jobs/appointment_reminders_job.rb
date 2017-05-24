class AppointmentRemindersJob < ApplicationJob

  def perform(users,appointments_dates,labs_cities,labs_addresses,labs_phones)
    appointments_dates=appointments_dates.collect {|ad| Time.at(ad)}
    users.each_with_index {|user,i| UserMailer.appointment_reminder_mail(user,appointments_dates[i],labs_cities[i],labs_addresses[i],labs_phones[i]).deliver}
    # Do something later
  end
end
