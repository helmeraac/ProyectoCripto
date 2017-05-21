class AddLabToResult < ActiveRecord::Migration[5.0]
  def change
    add_reference :results, :lab, foreign_key: {on_delete: :cascade}, index: true 
  end
end
