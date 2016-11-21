class AddViewCountToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :viewcount, :integer, default: 0
  end
end
