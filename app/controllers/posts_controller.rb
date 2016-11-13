class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			flash[:notice] = "Successfully created post."
			redirect_to posts_path 
		else
			render "new"
		end
	end

	def edit
	end

	def update
		
		if @post.update(post_params)
			flash[:notice] = "Successfully created updated."
			redirect_to post_path(@post)
		else
			render "edit"
		end 
	end

	def destroy 
		@post.destroy
		flash[:alert] = "Post has been deleted!"
		redirect_to posts_path
	end

	private
	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end

end
