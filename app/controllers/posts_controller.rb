class PostsController < ApplicationController
	before_action :find_post, only: [:new, :edit, :update, :destroy]
	before_action :find_post, only: [ :show, :like]
	before_action :find_own_post ,  only: [:edit, :update, :destroy]


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
			@posts = Category.find_by(name: "Current Affairs").posts
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

		if @post.user == current_user && @post.update(post_params)
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

	def like
		@liked_posts = current_user.liked_posts
		if @liked_posts.include?(@post)
			current_user.likes.find_by_post_id(@post).destroy
		else
			current_user.likes.create(:user_id => current_user, :post_id => @post.id)  
		end

		##Need to get new data from the database of @post again
		@post.reload
		respond_to do |format|
			format.js 
		end
	end


	# how to add validation#
	def bulk_update
		if current_user.role != "admin"
			redirect_to posts_path
			raise "You are not admin";
		end
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

	## Verify whether current user w
	def find_own_post
		@post = current_user.posts.find(params[:id])
	end
end
