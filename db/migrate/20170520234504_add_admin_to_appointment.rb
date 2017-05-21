class AddAdminToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :appointments, :admin, index: true
  end
end
