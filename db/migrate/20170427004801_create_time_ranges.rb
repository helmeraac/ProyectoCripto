class CreateTimeRanges < ActiveRecord::Migration[5.0]
  def change
    create_table :time_ranges do |t|
      t.integer :weekday
      t.datetime :start_time
      t.datetime :end_time
      t.references :shedule, foreign_key: true
      t.timestamps
    end
  end
end
