class UsersController < ApplicationController
	before_action :set_user, :except => [:index]
	def show		
		@comments = @user.comments.includes(:post)
	end

	def edit
	end

	def update
	end

	private 
	def set_user
		@user = User.find(params[:id])
	end

end
