# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'products#index'

  get '/search', to: 'products#search'
  get '/high_grade_search', to: 'products#high_grade_search'
  
  mount RuCaptcha::Engine => "/rucaptcha"

  namespace :admin do
   root 'home#index'
   resources :categories  

   resources :products, except: [:show]

   resources :users, only: [:index, :edit, :update, :destroy] do
     post 'add', on: :collection
     delete 'remove', on: :member
   end

   resources :orders, only: [:index, :edit, :update, :destroy]
   
   resources :coupons, only: [:index,:create]

   resources :awards, only: [:index,:create,:edit,:update,:destroy]
  end

  resources :products do
   get 'detail', on: :member
   resources :comments, only: [:index,:create, :destroy] 
  end

  resources :comments do
  get 'all', on: :member
  post 'ban', on: :member
  end

  resources :users, only: [:show,:edit,:update,:destroy]

  resources :carts, only: [:show,:destroy]

  resources :items, only: [:create,:destroy]

  resources :orders, only: [:index,:show,:create] do 
    post 'preview', on: :member
  end
  
  resources :marks, only: [:index, :create, :destroy] do
     delete 'remove', on: :member
  end

  resources :categories, only: [:show]

  resources :black_lists, only: [:create]

  resources :awards, only: [:index] do
    get 'show_all', on: :collection
    get 'judge', on: :collection
  end

  resources :coupons, only: [:index]
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
