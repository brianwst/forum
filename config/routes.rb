Rails.application.routes.draw do
	devise_for :users, controllers: {
        sessions: 'users/sessions', 
        omniauth_callbacks: 'users/omniauth_callbacks' }

    resources :users, only: [:show]


    namespace :admin do
    	resources :categories
    	resources :posts
      resources :users
    end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :posts do
		resources :comments, :controller => 'post_comments'
		collection do
        	get :about
          post :bulk_update
    	end
	end

	root to: "posts#index"
end
