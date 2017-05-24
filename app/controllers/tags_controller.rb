class TagsController < ApplicationController

  before_action :set_tag, only: [:destroy]

  before_action only: [:index,:destroy] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::NEWS])
  end


  def index
    @tags = Tag.all
  end

  def new

  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      session[:success_notice] =I18n.translate('models.tag.created')
      redirect_to tags_path
    else
      session[:error_notice] =@tag.errors.full_messages.join("<br />")
      render :new
    end
  end

  def destroy
    @tag.destroy
    if @tag.destroyed?
      render status: 200, json: {success: I18n.translate('models.tag.deleted')}
    else
      render status: 400, json: {errors: @tag.errors.full_messages.join("\n")}
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tag_params
    params.fetch(:tag, {}).permit(:name)
  end


  include AuthHelper


end
