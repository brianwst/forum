class Admin::UsersController < ApplicationController
	before_action :set_user 

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "User updated"
			redirect_to admin_posts_path
		else
			flash[:alert] = "Update unsuccessful"
			render "edit"
		end 
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:description, :role, :nickname, :first_name, :last_name)
	end


end
