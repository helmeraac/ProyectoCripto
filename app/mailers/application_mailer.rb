class ApplicationMailer < ActionMailer::Base
  default from: 'citopat@citopat.com'
  layout 'mailer'
  add_template_helper(EmailHelper)
end
