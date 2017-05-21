class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action only: [:index, :create, :destroy, :list] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::RESULTS])
  end

  before_action :authenticate_user!, only: [:user_list]
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
    @users = User.all
  end

  # GET /results/1
  # GET /results/1.json
  def show;
  end

  def user_list
    params[:user_id] = params[:id]
    params.delete :id
    user_result_list(result_list_params)
  end

  def list
    user_result_list(result_list_params)
  end

  def download_file
    @result = Result.find(download_file_params[:result_id])
    unless @result.nil?
      if current_admin.present?
        if PDFFileUploader.storage == CarrierWave::Storage::File
          send_file(@result.file_path.path, status: 200)
        elsif PDFFileUploader.storage == CarrierWave::Storage::Fog
          redirect_to Rails.configuration.fog_host + @result.file_path.path
        end
        return
      elsif current_user.present? && @result.user == current_user
        if PDFFileUploader.storage == CarrierWave::Storage::File
          send_file(@result.file_path.path, status: 200)
        elsif PDFFileUploader.storage == CarrierWave::Storage::Fog
          redirect_to Rails.configuration.fog_host + @result.file_path.path
        end
        return
      else
        render status: :unauthorized, json: {error: I18n.translate('models.result.download.unauthorized')}
      end
    end
  end

  # POST /results
  # POST /results.json
  def create
    params = result_params
    params[:user_id] = Base64.decode64(params[:user_id].to_s).to_i
    @result = Result.new(result_params)
    @result.user = User.find(params[:user_id])
    @result.upload_date = Time.now
    if @result.save
      session[:success_notice] = I18n.translate('models.result.created')
      redirect_to result_list_path(params[:user_id])
    else
      session[:error_notice] = @result.errors.full_messages.join(" <br/> ").html_safe
      redirect_to result_list_path(params[:user_id])
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json

  def destroy
    @result.destroy
    if @result.destroyed?
      render status: 200, json: {success: I18n.translate('models.result.deleted')}
    else
      render status: 400, json: {errors: @result.errors.full_messages}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_result
    @result = Result.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def result_params
    params.fetch(:result, {}).permit(:upload_date, :result_id, :file_path, :user_id, :lab_id, :name)
  end

  def result_user_list_params
    params.permit(:id)
  end

  def result_list_params
    params.permit(:user_id)
  end

  def download_file_params
    params.permit(:result_id)
  end

  include AuthHelper
  include ResultsHelper
end
