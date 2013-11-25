LifeBills::Application.routes.draw do

  get "user/signup_and_bind"
  resources :weixin_users

  resources :materials

  resources :bills do 
    collection do 
      post 'search'
    end
  end

	namespace :weixin_web do 
		post 'user/bind',   as: 'bind'
    get 'user/signup', as: 'signup'
    get 'user/signin', as: 'signin'
	end

  # resources :people

  # resources :accounts

  # resources :items

  # root to: 'devise/sessions#new'
  devise_for :users do
    root to: 'home#index',as: 'auth_root'
  end

  # get 'home/page'
  # root to: '/users'
  root to: 'home#index'

  scope '/settings' do
    resources :people
    resources :accounts

    resources :items
	end

  namespace :weixin do 
    weixin_rails_for_signature 'common#signature', as: 'weixin_signature', via: :get
    weixin_rails_for_event 'events#subscribe', event: 'subscribe', as: 'weixin_event_subscribe'
	
		weixin_rails_for_text 'common#missing', as: 'weixin_missing'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
