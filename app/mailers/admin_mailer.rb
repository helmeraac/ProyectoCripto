class AdminMailer < ApplicationMailer

  def welcome_mail(admin,generated_password)
    @admin = admin
    @url  = 'http://localhost:3000/admins/sign_in'
    @generated_password = generated_password
    mail(to: @admin.email, subject: 'Bienvenido al Sitio Admin')
  end
  def new_password_mail(admin,generated_password)
    @admin = admin
    @url  = 'http://localhost:3000/admins/sign_in'
    @generated_password = generated_password
    mail(to: @admin.email, subject: 'Nuevo Password Admin')
  end

end
