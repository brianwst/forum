class CreatePostCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :post_categoryships do |t|
    	t.belongs_to :post, index: true
    	t.belongs_to :category, index: true
		t.timestamps
    end
  end
end
