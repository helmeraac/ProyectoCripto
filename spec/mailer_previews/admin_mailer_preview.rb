class AdminMailerPreview < ActionMailer::Preview
  def welcome_mail
    AdminMailer.welcome_mail(Admin.first,"kjhkjhk")
  end
  def new_password_mail
    AdminMailer.new_password_mail(Admin.first,"kjhkjhk")
  end
end