class PostsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
	before_action :find_post, only: [ :show, :edit, :update, :destroy]
	def index
		
		@posts = Post.published
		
		case params[:order] 
		when "last_comment"
			sort_by = "comments.created_at DESC"
			@posts = @posts.includes(:comments, :user).order(sort_by)
		when "no_of_comments"
			sort_by = "comments_count DESC"
			@posts = @posts.includes(:comments, :user).order(sort_by)
		when "no_of_views"
			@posts = @posts.includes(:comments, :user).order("posts.viewcount DESC")
		else
			@posts = @posts.includes(:user)
		end

		
		case params[:sort]
		when "science"
			@posts = Category.find_by(name: "Science").posts
		when "sports"
			@posts = Category.find_by(name: "Sports").posts
		when "music"
			@posts = Category.find_by(name: "Music").posts
		when "current_affair"
			@posts = Category.find_by(name: "Cuent Affairs").posts
		else
			@posts = @posts.all
		end

		
	end

	def show
		@post.view!
		@comment = Comment.new
		@comments = @post.comments.includes(:user).published
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

	def about
		@users = User.all
		@comments = Comment.all
		@posts = Post.all
	end


	# how to add validation#
	def bulk_update
		ids = Array(params[:ids])
		posts = ids.map{ |i| Post.find_by_id(i) }.compact
		
		if params[:commit] == "Delete selected posts"
			posts.each{|e| e.destroy }
			flash[:notice] = "Posts deleted successfully"
		end

		redirect_to posts_path
	end


	private
	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content, :is_public, :category_ids => [])
	end

end
