class Post < ApplicationRecord
	validates_presence_of :title


	has_many :comments, :dependent => :destroy
	belongs_to :user

	has_many :post_categoryships
	has_many :categories, through: :post_categoryships

	has_many :bookmarks, :dependent => :destroy
	has_many :bookmark_users, through: :bookmarks, source: "user"

	has_many :likes, :dependent => :destroy
	has_many :liked_users, through: :likes, source: "user"
	
	scope :published, -> {where(is_public: true)}
	scope :draft, -> {where(is_public: false)}

	has_many :tag_posts
	has_many :tags, through: :tag_posts

	def view!
		self.viewcount += 1
		self.save
	end

end
