class Admin::CategoriesController < ApplicationController
	before_action :set_category, :except => [:index, :new, :create]
	#Need to add amin authenticate?
	def new
	end

	def create
		@category = Category.new(category_params)
		if @category.save 
			flash[:notice] = "Category created"
			redirect_to admin_posts_path
		else 
			flash[:alert] = "Category creation denied"
			render 'new'
		end
	end

	def edit
	end

	def update
		if @category.update(category_params)
			flash[:notice] = "Update Category"
			redirect_to admin_posts_path
		else
			flash[:alert] = "Category createion denied"
			render "edit"
		end
	end


	def destroy

		if @category.destroy
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.find(params[:id])
	end

end
