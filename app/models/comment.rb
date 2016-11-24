class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post, counter_cache: true

	scope :published, -> {where(is_public: true)}
	scope :draft, -> {where(is_public: false)}
end
