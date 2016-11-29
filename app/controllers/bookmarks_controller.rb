class BookmarksController < ApplicationController
	before_action :authenticate_user!

	def create
		@bookmark = Bookmark.new(bookmark_params)
		if @bookmark.save
			redirect_to posts_path
			flash[:notice] = "Bookmark created"
		end
	end

	def destroy
		@bookmark = Bookmark.find(params[:id])
		if @bookmark.destroy
			redirect_to posts_path
			flash[:alert] = "Bookmark deleted"
		end
	end

	private
	def set_post
		@post = Post.find(params[:post_id])
	end

	def bookmark_params
		params.permit(:user_id, :post_id)
	end
end
