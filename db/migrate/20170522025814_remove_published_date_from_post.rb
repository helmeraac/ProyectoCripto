class RemovePublishedDateFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :published_date
  end
end
