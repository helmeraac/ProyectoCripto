class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:edit, :update, :destroy, :change_state_admin, :change_state_user]
  before_action :authenticate_user!, only: [:list, :create, :change_state_user,:new]

  before_action only: [:index, :destroy, :change_state_admin, :update] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::APPOINTMENTS])
  end

  # GET /appointments
  # GET /appointments.json
  def index
    status = params[:status]
    if !status.nil? and !status.blank?
      @status = status
      if admin_permissions(current_admin).include?(Admin::MASTER)
        @appointments_list = Appointment.find_by_status(status)
      else
        @appointments_list = Appointment.find_by_lab_and_status(current_admin.lab.id, status)
      end
    end
  end

  def list
    @user_appointments = Appointment.find_by_user(current_user.id.to_i)
  end

  def new
    if current_user.present?
      @user_appointments = Appointment.find_by_user(current_user.id.to_i)
    end
  end

  def edit

  end

  # POST /appointments
  # POST /appointments.json
  def create
    if current_user.present?
      lab = Lab.find(appointment_params[:lab_id])
      if !lab.nil?
        @appointment = Appointment.new(lab: lab)
        @appointment.user = current_user
        @appointment.status = Appointment::CONFIRMED
        datetime = DateTime.strptime(appointment_params[:date]+" "+appointment_params[:hour]+" -0500", '%m/%d/%Y %I:%M %p %z')
        @appointment.date = datetime
        if lab.calculate_availability(datetime).count > 0
          @user_requested_appoinments = Appointment.find_by_user_and_status(current_user.id, Appointment::CONFIRMED)
          if @user_requested_appoinments.count >= Appointment::MAX_APPOINTMENTS_PER_USER
            session[:error_notice] = I18n.translate('models.appointment.too_many_requested', count: Appointment::MAX_APPOINTMENTS_PER_USER)
            render :new
            return
          end
          if @appointment.save
            session[:success_notice] = I18n.translate('models.appointment.created')
            redirect_to new_appointment_path
            return
          else
            session[:error_notice] = @appointment.errors.full_messages.join("<br />")
            render :new
            return
          end
        else
          session[:error_notice] = I18n.translate('models.lab.not_available_times', count: Appointment::MAX_APPOINTMENTS_PER_USER)
          render :new
          return
        end
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    if current_user.present?
      lab = Lab.find(appointment_params[:lab_id])
      if !lab.nil?
        datetime = DateTime.strptime(appointment_params[:date]+" "+appointment_params[:hour]+" -0500", '%m/%d/%Y %I:%M %p %z')
        @appointment.date = datetime
        if lab.calculate_availability(datetime).count > 0
          if @appointment.save
            session[:success_notice] = I18n.translate('models.appointment.updated')
            redirect_to edit_appointment_path(@appointment.id)
            return
          else
            session[:error_notice] = @appointment.errors.full_messages.join("<br />")
            render :edit
            return
          end
        else
          session[:error_notice] = I18n.translate('models.lab.not_available_times', count: Appointment::MAX_APPOINTMENTS_PER_USER)
          render :edit
          return
        end
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    if @appointment.destroyed?
      render status: 200, json: {success: I18n.translate('models.appointment.deleted')}
    else
      render status: 400, json: {errors: @appointment.errors.full_messages}
    end
  end

  def change_state_user
    change_state(1)
  end

  def change_state_admin
    change_state(0)
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.fetch(:appointment, {}).permit(:date, :lab_id, :hour, :status)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_list_params
    params.permit(:user_id)
  end

  def appointment_change_state_params
    params.fetch(:appointment, {}).permit(:status)
  end

  include AuthHelper
  include AppointmentsHelper
end
