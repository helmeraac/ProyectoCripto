class RemoveAccessLevelFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :access_level
  end
end
