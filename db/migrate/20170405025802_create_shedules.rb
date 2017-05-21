class CreateShedules < ActiveRecord::Migration[5.0]
  def change
    create_table :shedules do |t|
      t.string :weekdays
      t.string :hours_per_day
      t.references :lab, foreign_key: true

      t.timestamps
    end
  end
end
