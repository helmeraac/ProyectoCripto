class AddAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :admin, index: true
  end
end
