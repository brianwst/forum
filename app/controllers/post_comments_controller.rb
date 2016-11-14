class PostCommentsController < ApplicationController
	before_action :find_post
	def new
		@comment = @post.comments.build
	end

	def create
		##QUestion on how to solve this problem: can't assign user_id 
		@comment = @post.comments.new(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:notice] = "Reply successfully made"
			redirect_to post_path(@post)
		else 
			render 'new'
		end
	end

	private 
	def find_post
		@post = Post.find(params[:post_id])
	end

	def comment_params
		params.require(:comment).permit(:content, :user_id, :post_id)
	end
end
