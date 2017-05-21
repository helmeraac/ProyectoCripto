class AddStatusToAppoinment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments,:status,:integer
  end
end
