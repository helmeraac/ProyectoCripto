class AdminMailerPreview < ActionMailer::Preview
  def welcome_mail
    AdminMailer.welcome_mail(Admin.first,Admin.first.password)
  end
end