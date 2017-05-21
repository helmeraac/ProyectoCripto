class UserMailer < ApplicationMailer

  def welcome_mail(user, generated_password)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    @generated_password = generated_password
    mail(to: @user.email, subject: 'Bienvenido al Sitio User')
  end

  def new_password_mail(user, generated_password)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    @generated_password = generated_password
    mail(to: @user.email, subject: 'Nuevo Password')
  end

  def canceled_appointment_mail(user,appointment_date)
    @user = user
    appointment_date = Time.at(appointment_date)
    @appointment_date = appointment_date.strftime("%m/%d/%Y")
    @appointment_hour = appointment_date.strftime("%I:%M %p")
    mail(to: @user.email, subject: 'Cita Cancelada')
  end

  def appointment_reminder_mail(user,appointment_date)
    @user = user
    @appointment_date = appointment_date.strftime("%m/%d/%Y")
    @appointment_hour = appointment_date.strftime("%I:%M %p")
    mail(to: @user.email, subject: 'Recordatorio de Cita')
  end

end
