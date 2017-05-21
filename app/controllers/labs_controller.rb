class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :lab_availability]
  before_action except: [:lab_availability] do
    authenticate_admin_with_permissions!([Admin::MASTER])
  end
  before_action :authenticate_user!, only:[:lab_availability]

  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all
  end

  def lab_availability
    if lab_availability_params[:appointment_date]
      appointment_date = DateTime.strptime(lab_availability_params[:appointment_date]+" 01:00 AM -0500", '%m/%d/%Y %I:%M %p %z')
      available_hours = @lab.calculate_availability(appointment_date)
      if available_hours.count > 0
        render status: 200, json: {available_hours: available_hours.to_s}
      else
        render status: 400, json: {message: I18n.translate('models.lab.not_available_times')}
      end
    end
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(city: lab_params[:city], address: lab_params[:address])
    if @lab.save
      @schedule = Shedule.new(lab: @lab)
      if @schedule.save
        render status: 200, json: {success: I18n.translate('models.lab.created')}
      else
        render status: 400, json: {errors: @schedule.errors.full_messages.join("\n")}
      end
    else
      render status: 400, json: {errors: @lab.errors.full_messages.join("\n")}
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    if @lab.update(lab_params)
      render status: 200, json: {success: I18n.translate('models.lab.updated')}
    else
      render status: 400, json: {errors: @lab.errors.full_messages}
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    if @lab.destroyed?
      render status: 200, json: {success: I18n.translate('models.lab.deleted')}
    else
      render status: 400, json: {errors: @lab.errors.full_messages}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lab
    @lab = Lab.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lab_params
    params.fetch(:lab, {}).permit(:city, :address, days: [], start_time: [], end_time: [])
  end

  def lab_availability_params
    params.permit(:appointment_date)
  end

  include AuthHelper
end
