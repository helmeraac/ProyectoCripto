class UserFieldsAdjustment < ActiveRecord::Migration[5.0]
  def change
    remove_column :users,:website
    add_column :users,:city,:string
    add_column :users,:user_type,:integer
  end
end
