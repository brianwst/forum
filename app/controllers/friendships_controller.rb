class FriendshipsController < ApplicationController
	before_action :set_user
	def create
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
		if @friendship.save
			params[:notice] = "Friend added"
			redirect_to user_path(@user.id)
		else 
			params[:alert] = "Unable to add friend"
			redirect_to user_path(@user.id)
		end
	end

	def destroy
		@friendship = current_user.friendships.find_by(params[:id])
		if @friendship.destroy
			flash[:notice] = "Friend removed"
		else
			flash[:alert] = "Friend removed unsucessful"
		end
		redirect_to user_path(@user.id)

	end

	private 
	def set_user
		@user = User.find_by_id(current_user.id)
	end

end
