class AdminsController < ApplicationController
  before_action :set_admin, only: %i[show edit update destroy regenerate_admin_password]
  before_action do
    authenticate_admin_with_permissions!([Admin::MASTER])
  end
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.create_admin_with_random_pass(admin_params)
    if @admin.save
      AdminMailer.welcome_mail(@admin, @admin.password).deliver_later
      render status: 200, json: {success: I18n.translate('models.admin.created')}
    else
      render status: 400, json: {message: @admin.errors.full_messages.join("\n")}
    end
  end

  def regenerate_admin_password
    unless @admin.nil?
      regenerate = @admin.regenerate_password
      if regenerate
        AdminMailer.new_password_mail(@admin, @admin.password).deliver_later
        render status: 200, json: {success: I18n.translate('models.admin.password.updated')}
      else
        render status: 400, json: {message: @admin.errors.full_messages.join("\n")}
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    if admin_external_params[:delete_photo] == "true"
      @admin.remove_photo = true;
      @admin.save
    end
    if @admin.update(admin_params)
      render status: 200, json: {success: I18n.translate('models.admin.updated')}
    else
      render status: 400, json: {errors: @admin.errors.full_messages}
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    if Admin.count == 1
      render status: 400, json: {error: I18n.translate('models.admin.cant_delete_last_one')}
      return
    end
    @admin.destroy
    if @admin.destroyed?
      render status: 200, json: {success: I18n.translate('models.admin.deleted')}
    else
      render status: 400, json: {errors: @admin.errors.full_messages}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.fetch(:admin, {}).permit(:email, :password, :password_confirmation, :name, :photo, :bio, :permissions, :lab_id)
  end

  def admin_external_params
    params.permit(:delete_photo)
  end

  include AuthHelper
end
