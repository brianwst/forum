class UsersController < ApplicationController
	before_action :set_user, :except => [:index]

	def show	
	unless @user
		@user = User.find_by_id(params[:id])
	end
		@comments = @user.comments.includes(:post)
		@bookmark = @user.bookmark_posts

	end

	def edit
	end

	def update
	end

	private 
	def set_user 
		@user = User.find_by_nickname(params[:id])
	end

end
