class AddStatusToPickupRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :pickup_requests,:status,:integer,default:0
  end
end
