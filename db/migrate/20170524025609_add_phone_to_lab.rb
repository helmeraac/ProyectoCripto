class AddPhoneToLab < ActiveRecord::Migration[5.0]
  def change
    add_column :labs,:phone,:string
  end
end
