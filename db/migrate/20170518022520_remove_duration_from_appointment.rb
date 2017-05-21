class RemoveDurationFromAppointment < ActiveRecord::Migration[5.0]
  def change
    remove_column :appointments,:duration
  end
end
