class CreateTagPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_posts do |t|
    	t.integer :post_id, index: true
    	t.integer :tag_id, index: true
    	t.timestamps
    end
  end
end
