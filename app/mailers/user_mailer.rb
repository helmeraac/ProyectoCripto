class UserMailer < ApplicationMailer

  def welcome_mail(user, generated_password)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    @generated_password = generated_password
    mail(to: @user.email, subject: "Bienvenido(a) - Citopat de Colombia")
  end

  def new_password_mail(user, generated_password)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    @generated_password = generated_password
    mail(to: @user.email, subject: "Su contraseña ha sido restaurada - Citopat de Colombia")
  end

  def canceled_appointment_mail(user,appointment_date,lab_city,lab_address,lab_phone)
    @user = user
    appointment_date = Time.at(appointment_date)
    @lab = lab_city
    @lab_address = lab_address
    @lab_phone = lab_phone
    @appointment_date = I18n.localize(appointment_date, format: '%d de %B de %Y')
    @appointment_hour = appointment_date.strftime("%I:%M %p")
    mail(to: @user.email, subject: "Su cita ha sido cancelada - Citopat de Colombia")
  end

  def appointment_reminder_mail(user,appointment_date,lab_city,lab_address,lab_phone)
    @user = user
    @lab = lab_city
    @lab_address = lab_address
    @lab_phone = lab_phone
    @appointment_date = I18n.localize(appointment_date, format: '%d de %B de %Y')
    @appointment_hour = appointment_date.strftime("%I:%M %p")
    mail(to: @user.email, subject: "Recordatorio de Cita - Citopat de Colombia")
  end

end
