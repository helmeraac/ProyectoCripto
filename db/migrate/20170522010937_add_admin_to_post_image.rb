class AddAdminToPostImage < ActiveRecord::Migration[5.0]
  def change
    add_reference :post_images,:admin,index:true
  end
end
