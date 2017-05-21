class AddExtraFieldsToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :photo, :string
    add_column :admins, :bio, :text
  end
end
