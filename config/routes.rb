Rails.application.routes.draw do
  
  get '/friends'    => 'static_pages#friends'
  get '/photos'     => 'static_pages#photos'

  concern :commentable do
    resources :comments, only: [:create]
  end

  concern :likeable do
    resources :likes, only: [:create]
  end

  resources :users, only: [:new, :create] do
    resource :profile, only: [:show]
    resources :posts, only: [:index]
    resources :friends, only: [:index]
    resources :photos, only: [:index]
    get 'timeline'  => 'posts#index'
    get 'search', on: :collection
  end

  resource :profile, only: [:edit, :update]
  resources :posts, only: [:create, :destroy], 
                    concerns: [:commentable, :likeable]
  resources :comments, only: [:destroy], concerns: [:likeable]
  resources :likes, only: [:destroy]
  resources :friends, only: [:create, :destroy]
  resources :photos, only: [:show, :new, :create, :destroy]

  resource :sessions, only: [:create, :destroy]

  get 'signup'      => 'users#new'
  root 'users#new'

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
