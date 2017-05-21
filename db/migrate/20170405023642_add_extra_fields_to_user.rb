class AddExtraFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :website, :string
    add_column :users, :doc, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :access_level, :integer
  end
end
