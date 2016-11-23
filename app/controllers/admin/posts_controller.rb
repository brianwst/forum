class Admin::PostsController < ApplicationController
	
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@categories = Category.all
		if params[:id]
			@category = Category.find(params[:id])
		else
			@category = Category.new
		end

		@users = User.all 
	end


	private
	def check_admin
		unless current_user.role == "admin"
			flash[:alert] = "You are not admin"
			redirect_to posts_path
		end
	end
end
