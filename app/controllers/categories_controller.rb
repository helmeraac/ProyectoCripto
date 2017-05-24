class CategoriesController < ApplicationController

  before_action :set_category, only: [:destroy]

  before_action only: [:index, :destroy,:create,:new] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::NEWS])
  end


  def index
    @categories = Category.all
  end

  def new

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      session[:success_notice] =I18n.translate('models.category.created')
      redirect_to categories_path
    else
      session[:error_notice] =@category.errors.full_messages.join("<br />")
      render :new
    end
  end

  def destroy
    @category.destroy
    if @category.destroyed?
      render status: 200, json: {success: I18n.translate('models.category.deleted')}
    else
      render status: 400, json: {errors: @category.errors.full_messages.join("\n")}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.fetch(:category, {}).permit(:name)
  end


  include AuthHelper


end
