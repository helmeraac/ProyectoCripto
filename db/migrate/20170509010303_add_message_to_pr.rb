class AddMessageToPr < ActiveRecord::Migration[5.0]
  def change
    add_column :pickup_requests,:message,:string
    add_column :pickup_requests,:date,:datetime
  end
end
