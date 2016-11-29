class Bookmark < ApplicationRecord
	belongs_to :user
	belongs_to :post
	delegate :title, to: :post, prefix: true, allow_nil: true

end
