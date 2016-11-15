class Post < ApplicationRecord
	validates_presence_of :title
	
	has_many :comments, :dependent => :destroy
	belongs_to :user

	has_many :post_categoryships
	has_many :categories, through: :post_categoryships
end
