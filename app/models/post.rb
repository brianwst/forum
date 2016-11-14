class Post < ApplicationRecord
	validates_presence_of :title
	has_many :comments, :dependent => :destroy
	belongs_to :user
end
