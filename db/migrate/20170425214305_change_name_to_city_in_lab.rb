class ChangeNameToCityInLab < ActiveRecord::Migration[5.0]
  def change
    rename_column :labs, :name,:city
  end
end
