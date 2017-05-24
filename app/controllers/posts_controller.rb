class PostsController < ApplicationController

  before_action :set_post, only: [:destroy, :edit, :update, :show]

  before_action only: [:index, :new, :create, :destroy, :edit, :update] do
    authenticate_admin_with_permissions!([Admin::MASTER, Admin::NEWS])
  end


  def index
    if admin_permissions(current_admin).include?(Admin::MASTER)
      @posts = Post.all.order(updated_at: :desc)
    else
      @posts = Post.for_admin(current_admin).order(updated_at: :desc)
    end

    render 'newsListAdmin'
  end

  def show

  end

  def list
    random_categories_and_tags
    @posts = Post.paginate(:page => post_paginate_params[:page], :per_page => Post::PER_PAGE).order(created_at: :desc)
    @page = post_paginate_params[:page]
    @title = "Noticias"
    @breadcrumb = "Todas las Noticias"
    @pagination_base = "/news/"
  end

  def list_by_category
    random_categories_and_tags
    category = Category.find(post_by_category_params[:category_id])
    @posts = Post.by_category(category).paginate(:page => post_by_category_params[:page], :per_page => Post::PER_PAGE).order(created_at: :desc)
    @page = post_paginate_params[:page] || 1
    @title = "Noticias - #{category.name}"
    @breadcrumb = "Noticias - #{category.name}"
    @pagination_base = "/news/category/#{category.id}/?page="
    render 'list'
  end

  def list_by_tag
    random_categories_and_tags
    tag = Tag.find(post_by_tag_params[:tag_id])
    @posts = Post.by_tag(tag).paginate(:page => post_by_tag_params[:page], :per_page => Post::PER_PAGE).order(created_at: :desc)
    @page = post_paginate_params[:page] || 1
    @title = "Noticias - #{tag.name}"
    @breadcrumb = "Noticias - #{tag.name}"
    @pagination_base = "/news/tag/#{tag.id}/?page="
    render 'list'
  end

  def edit

  end

  def new

  end

  def create
    @post = Post.new(post_params)
    @post.admin = current_admin
    if @post.save
      post_images = post_body_params[:html_body_images].split(',')
      post_images.each do |post_image_id|
        post_image = PostImage.find(post_image_id.to_i)
        post_image.post = @post
        post_image.save
      end
      remove_unsaved_post_images
      # session[:success_notice] =I18n.translate('models.post.created')
      render status: 200, json: {success: I18n.translate('models.post.created')}
    else
      # session[:error_notice] =@post.errors.full_messages.join("\n")
      render status: 400, json: {message: @post.errors.full_messages.join("\n")}
    end
  end

  def update
    post_images = @post.post_images
    post_images.each do |post_image|
      post_image.admin = current_admin
      post_image.post = nil
      post_image.save
    end
    if post_external_params[:delete_image] == "true"
      @post.remove_header_img = true
      @post.save
    end
    @post.admin = current_admin
    if @post.update(post_params)
      post_images = post_body_params[:html_body_images].split(',')
      post_images.each do |post_image_id|
        post_image = PostImage.find(post_image_id.to_i)
        post_image.post = @post
        post_image.save
      end
      remove_unsaved_post_images
      # session[:success_notice] =I18n.translate('models.post.created')
      render status: 200, json: {success: I18n.translate('models.post.updated')}
    else
      # session[:error_notice] =@post.errors.full_messages.join("\n")
      render status: 400, json: {message: @post.errors.full_messages.join("\n")}
    end
  end

  def destroy
    @post.post_images.each do |post_image|
      post_image.remove_image = true
      post_image.save
    end
    @post.destroy
    if @post.destroyed?
      render status: 200, json: {success: I18n.translate('models.post.deleted')}
    else
      render status: 400, json: {errors: @post.errors.full_messages.join("\n")}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.fetch(:post, {}).permit(:title, :html_body, :html_summary, :header_img, :category_ids => [], :tag_ids => [])
  end

  def post_body_params
    params.fetch(:post, {}).permit(:html_body_images)
  end

  def post_external_params
    params.permit(:delete_image)
  end

  def post_paginate_params
    params.permit(:page)
  end

  def post_by_category_params
    params.permit(:category_id, :page)
  end

  def post_by_tag_params
    params.permit(:tag_id, :page)
  end

  def random_categories_and_tags
    tags=Tag.select(:id).all.sort_by {rand}.slice(0, 10)
    @tags = Tag.where(:id => tags)
    categories=Category.select(:id).all.sort_by {rand}.slice(0, 10)
    @categories = Category.where(:id => categories)
  end

  def remove_unsaved_post_images
    pimgs = PostImage.without_post_for_admin(current_admin)
    pimgs.each do |pimg|
      pimg.remove_image = true
      pimg.save
    end
    PostImage.delete(pimgs)
  end

  include AuthHelper

end
