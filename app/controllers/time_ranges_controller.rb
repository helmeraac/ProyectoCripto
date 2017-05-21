class TimeRangesController < ApplicationController
  before_action :set_time_range, only: [:destroy]
  before_action :authenticate_admin!


  def list
    @lab = Lab.find(time_range_list_params[:lab_id])
    @lab_time_ramges = TimeRange.find_by_shedule(@lab.shedule)
  end

#   # GET /labs
#   # GET /labs.json
#   def index
#     @labs = Lab.all
#   end

# POST /labs
# POST /labs.json
  def create
    lab = Lab.find(time_range_list_params[:lab_id])
    params[:time_range][:shedule_id] = lab.shedule.id
    @time_range = TimeRange.create_time_range(time_range_params)
    if @time_range.save
      render status: 200, json: {success: I18n.translate('models.time_range.created')}
    else
      render status: 400, json: {errors: @time_range.errors.full_messages.join("\n")}
    end
  end

#   # PATCH/PUT /labs/1
#   # PATCH/PUT /labs/1.json
#   def update
#     if @lab.update(lab_params)
#       render status: 200, json: { success: I18n.translate('models.lab.updated') }
#     else
#       render status: 400, json: { errors: @lab.errors.full_messages }
#     end
#   end

# DELETE /labs/1
# DELETE /labs/1.json
  def destroy
    @time_range.destroy
    if @time_range.destroyed?
      render status: 200, json: {success: I18n.translate('models.time_range.deleted')}
    else
      render status: 400, json: {errors: @time_range.errors.full_messages.join("\n")}
    end
  end

  private

# Use callbacks to share common setup or constraints between actions.
  def set_time_range
    @time_range = TimeRange.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def time_range_params
    params.fetch(:time_range, {}).permit(:weekday, :start_time, :end_time, :shedule_id)
  end

  def time_range_list_params
    params.permit(:lab_id)
  end

end
