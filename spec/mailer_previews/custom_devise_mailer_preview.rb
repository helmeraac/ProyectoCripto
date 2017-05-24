class CustomDeviseMailerPreview < ActionMailer::Preview

  def reset_password_instructions
    CustomDeviseMailer.reset_password_instructions(User.first, "faketoken")
  end
  def reset_password_instructions_admin
    CustomDeviseMailer.reset_password_instructions(Admin.first, "faketoken")
  end

end
