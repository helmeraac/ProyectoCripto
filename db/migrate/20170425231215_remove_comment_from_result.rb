class RemoveCommentFromResult < ActiveRecord::Migration[5.0]
  def change
    rename_column :results, :comment, :name
  end
end
