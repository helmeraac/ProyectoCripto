class PickupRequestsController < ApplicationController
  before_action :set_pickup_request, only: %i[destroy user_destroy show change_state]
  before_action only: %i[index destroy] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::PICKUP_REQUESTS])
  end
  before_action :authenticate_user!, only: %i[list user_destroy]

  # GET /pickup_requests
  # GET /pickup_requests.json
  def index
    @pickup_requests = PickupRequest.all
  end

  def new
    if current_user
      @user_pickup_requests = PickupRequest.for_user(current_user.id.to_i)
    end
  end

  def show
    @actual_pickup_request = @pickup_request
    render 'detail'
  end

  def list
    @user_pickup_requests = PickupRequest.for_user(current_user.id.to_i)
  end

  # POST /pickup_requests
  # POST /pickup_requests.json
  def create
    # Creates PR
    begin
    @pickup_request = PickupRequest.new(pickup_request_params)
    @pickup_request.status = PickupRequest::PENDING
    @pickup_request.date = Date.strptime(pickup_request_params[:date], '%m/%d/%Y')

    if current_user.present?
      # User Logged
      @pickup_request.user = current_user
      @user_pickups_active_requests = PickupRequest.active_for_user(current_user.id)
      if @user_pickups_active_requests.count >= PickupRequest::MAX_PENDING_REQUESTS_PER_USER
        session[:error_notice] = I18n.translate('models.pickup_request.too_many_active')
        redirect_to new_pickup_request_path
        return
      end
    else
      # User Not Logged
      user = User.find_by_email(user_params[:email])
      if !user.nil?
        # User Not Logged, But It Exists
        session[:error_notice] = I18n.translate('models.pickup_request.user.exists', email: user.email)
        render :new
        return
      else
        # User Not Logged, And it Doesnt Exists
        user = User.create_user_with_random_pass(user_params)
        if user.valid?
          @pickup_request.user = user
        else
          session[:error_notice] = user.errors.full_messages.join('<br/>')
          render :new
          return
        end
      end
    end

    if @pickup_request.save
      flash[:notice] = I18n.translate('models.pickup_request.created')
      redirect_to root_path
    else
      session[:error_notice] = @pickup_request.errors.full_messages.join('<br/>')
      render :new
    end
    rescue Exception => error
      session[:error_notice] = "Ha ocurrido un error desconocido"
      render :new
    end
  end

  # DELETE /pickup_requests/1
  # DELETE /pickup_requests/1.json
  def destroy
    @pickup_request.destroy
    if @pickup_request.destroyed?
      render status: 200, json: {success: I18n.translate('models.pickup_request.deleted')}
    else
      render status: 400, json: {errors: @pickup_request.errors.full_messages}
    end
  end

  def user_destroy
    if current_user.present? && @pickup_request.user == current_user
      if @pickup_request.status != PickupRequest::PENDING
        render status: 400, json: {message: I18n.translate('models.pickup_request.cant_delete_in_progress')}
        return
      end
      @pickup_request.destroy
      if @pickup_request.destroyed?
        render status: 200, json: {success: I18n.translate('models.pickup_request.canceled')}
      else
        render status: 400, json: {message: @pickup_request.errors.full_messages.join('<br/>')}
      end
    else
      render status: 400, json: {message: I18n.translate('models.pickup_request.not_owner')}
    end
  end

  def change_state
    if @pickup_request.verify_status_change(pickup_request_params[:status].to_i)
      @pickup_request.status = pickup_request_params[:status].to_i
    else
      pr = PickupRequest.new(status: pickup_request_params[:status].to_i)
      render status: 400, json: {message: I18n.translate('models.pickup_request.cant_change_status', new_status: pr.status_string)}
      return
    end

    if @pickup_request.save
      render status: 200, json: {success: I18n.translate('models.pickup_request.status_changed', new_status: @pickup_request.status_string)}
    else
      render status: 400, json: {message: @pickup_request.errors.full_messages.join('\n')}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pickup_request
    @pickup_request = PickupRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pickup_request_params
    params.fetch(:pickup_request, {}).permit(:latitude, :longitude, :address, :message, :status, :date)
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :name, :lastname, :doc, :address, :phone, :city).merge(user_type: User::PARTICULAR, address: @pickup_request.address)
  end

  def pickup_request_list_params
    params.permit(:user_id)
  end

  include AuthHelper
end
