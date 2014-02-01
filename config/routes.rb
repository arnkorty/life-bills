# encoding: utf-8
LifeBills::Application.routes.draw do

  get "bills/export", as: :export_bills
  # get "bills/search"
  get "url/:url" => 'url#index'
  # get "user/signup_and_bind"
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
    patch 'bills' => 'bills#update', as: 'bills'
    resources :bills do 
      get 'get_items', on: :collection
    end
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
    weixin_rails_for_signature 'common#signature', as: 'weixin_signature', via: [:get, :post]
    weixin_rails_for_event 'events#subscribe', event: 'subscribe', as: 'weixin_event_subscribe'
    weixin_rails_for_event 'events#unsubscribe', event: 'unsubscribe', as: 'weixin_event_unsubscribe'
    weixin_rails_for_text 'bills#search',content: /^bills#search/, as: "weixin_bills_search"
    weixin_rails_for_text 'common#url',content: /^url/, as: "weixin_url"
    weixin_rails_for_text 'common#help',content: /(^help$)|(^帮助$)|(^\?$)/, as: "weixin_help"
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
