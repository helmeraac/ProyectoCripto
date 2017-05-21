class CustomDeviseMailer < Devise::Mailer
  layout 'mailer'
  add_template_helper(EmailHelper)
end
