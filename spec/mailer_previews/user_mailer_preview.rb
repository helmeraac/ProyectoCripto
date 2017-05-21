class UserMailerPreview < ActionMailer::Preview
  def welcome_mail
    UserMailer.welcome_mail(User.first,User.first.password)
  end
end