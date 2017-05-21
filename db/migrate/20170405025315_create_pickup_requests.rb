class CreatePickupRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pickup_requests do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
