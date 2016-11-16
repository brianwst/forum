class PostsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
		case params[:order] 
		when "last_comment"
			sort_by = "comments.created_at DESC"
			@posts = @posts.includes(:comments, :user).order(sort_by)
		when "no_of_comments"
			sort_by = "comments_count DESC"
			@posts = @posts.includes(:comments, :user).order(sort_by)
		else
			@posts = @posts.includes(:user)
		end



	end

	def show
		@comment = Comment.new
		@comments = @post.comments.includes(:user)
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

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
		params.require(:post).permit(:title, :content, :category_ids => [])
	end

end
