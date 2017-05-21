class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.integer :duration
      t.references :lab, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
