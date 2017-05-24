class PostImagesController < ApplicationController

  before_action :set_post_image, only: [:destroy]

  before_action only: [:create,:destroy] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::NEWS])
  end


  # POST /post_images
  # POST /post_images.json
  def create
    @post_image = PostImage.new(post_image_params)

    respond_to do |format|
      if @post_image.save
        format.json {render json: {url: @post_image.image.url,image_id: @post_image.id}}
      else
        format.html {render :new}
        format.json {render json: @post_image.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /post_images/1
  # DELETE /post_images/1.json
  def destroy
    @post_image.destroy
    respond_to do |format|
      format.html {redirect_to post_images_url, notice: 'Post image was successfully destroyed.'}
      format.json {head :ok}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post_image
    @post_image = PostImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_image_params
    params.require(:post_image).permit(:image,:admin_id)
  end
  include AuthHelper
end
