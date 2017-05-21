class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :regenerate_user_password]
  before_action do
    authenticate_admin_with_permissions!([Admin::MASTER,Admin::RESULTS])
  end
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create_user_with_random_pass(user_params)
    @user.admin = current_admin
    @user.save
    if @user.valid?
      render status: 200, json: { success: I18n.translate('models.user.created') }
    else
      render status: 400, json: { message: @user.errors.full_messages.join("\n") }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render status: 200, json: { success: I18n.translate('models.user.updated') }
    else
      render status: 400, json: { errors: @user.errors.full_messages }
    end
  end

  def regenerate_user_password
    unless @user.nil?
      regenerate = @user.regenerate_password
      if regenerate
        UserMailer.new_password_mail(@user, @user.password).deliver_later
        render status: 200, json: { success: I18n.translate('models.user.password.updated') }
    else
        render status: 400, json: { message: @user.errors.full_messages.join("\n") }
    end
    end
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    if @user.destroyed?
      render status: 200, json: { success: I18n.translate('models.user.deleted') }
    else
      render status: 400, json: { errors: @user.errors.full_messages }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :name, :lastname, :doc, :address, :phone,:user_type,:city)
  end

  include AuthHelper
end
