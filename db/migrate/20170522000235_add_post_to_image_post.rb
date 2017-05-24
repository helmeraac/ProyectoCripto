class AddPostToImagePost < ActiveRecord::Migration[5.0]
  def change
    add_reference :post_images,:post,index:true
  end
end
