class AddPermissionsAndLabToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_reference :admins, :lab, foreign_key: true
    add_column :admins, :permissions, :integer
  end
end
