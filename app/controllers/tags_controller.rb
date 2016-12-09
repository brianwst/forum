class TagsController < ApplicationController
	before_action :set_post 

	def create
		@tag = Tag.new(params_tag)
		if @tag.save 
			@post.tag_posts.create(:post_id => @post.id, :tag_id => @tag.id)
			respond_to do |format|
				format.js
			end
		else
			flash[:alert] = "Tags not created"
			redirect_to post_path(@post)
		end

	end
	
	private
	def set_post
		@post = Post.find(params[:post_id])
	end

	def params_tag
		params.require(:tag).permit(:name)
	end
end