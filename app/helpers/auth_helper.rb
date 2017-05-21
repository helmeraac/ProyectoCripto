module AuthHelper
  private
  include AdminHelper
#
# def authenticate_user_or_admin!
#   flash.clear
#   if !current_admin.present? && !current_user.present?
#     flash['notice'] = I18n.translate('devise.failure.unauthenticated')
#     redirect_to(new_user_session_path) && return
#   end
# end

  def authenticate_admin_with_permissions!(permissions)
    flash.clear
    if !admin_signed_in?
      flash['notice'] = I18n.translate('devise.failure.unauthenticated')
      redirect_to(new_admin_session_path) && return
    else
      has_permissions = false
      admin_permissions = admin_permissions(current_admin)
      permissions.each do |permission|
        has_permissions = true if admin_permissions.include?(permission)
      end
      unless has_permissions == true
        flash['notice_error'] = I18n.translate('admin.failure.no_permissions')
        redirect_to(admin_index_path) && return
      end
    end
  end

  # def check_user_is_owner(model, model_class_name)
  #   if current_user.present?
  #     if model.user != current_user
  #       render status: 400, json: {error: I18n.translate('models.' + model_class_name + '.not_owner')}
  #       false
  #     else
  #       true
  #     end
  #   else
  #     true
  #   end
  # end
end
