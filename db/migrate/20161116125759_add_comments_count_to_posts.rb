class AddCommentsCountToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :comments_count, :integer, default: 0
  	Post.pluck(:id).each do |i|
      Post.reset_counters(i, :comments) # 全部重算一次
    end
  end
end
