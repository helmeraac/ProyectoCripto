class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :published_date
      t.string :html_body
      t.string :header_img
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
