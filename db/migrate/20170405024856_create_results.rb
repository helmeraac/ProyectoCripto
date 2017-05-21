class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.datetime :upload_date
      t.string :comment
      t.string :file_path
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
