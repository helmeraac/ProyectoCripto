class AddSummaryToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts,:html_summary,:string
  end
end
