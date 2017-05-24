class UserMailerPreview < ActionMailer::Preview
  def welcome_mail
    UserMailer.welcome_mail(User.first, "asdasdasd")
  end

  def new_password_mail
    UserMailer.new_password_mail(User.first, "asdasdasd")
  end

  def canceled_appointment_mail
    lab = Lab.all.sample
    UserMailer.canceled_appointment_mail(User.first, Time.now,lab.city,lab.address,lab.phone)
  end

  def appointment_reminder_mail
    lab = Lab.all.sample
    UserMailer.appointment_reminder_mail(User.first, Time.now,lab.city,lab.address,lab.phone)
  end
end