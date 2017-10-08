Rails.application.routes.draw do
  resources :events
  devise_for :admins
  devise_for :accounts, controllers: { registrations: "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'accounts#index'

  match '/contacts', to: 'pages#index', via: 'get'
  resources "contacts", only: [:new, :create]
  
  resources :students do
    collection do
      get 'search'
      get 'admin_search'
      post 'reset'
      post 'transfer'
    end
  end

  resources :groupslots do
    collection do
      post 'reset'
      post 'clean_groups'
    end
  end

  resources :admins do
    collection do
      get 'index'
      get 'accounts'
      get 'students'
      get 'timeslots'
      get 'writeups'
      post 'clean_timeslots'
    end
  end

  match 'accounts/:id' => 'accounts#destroy', :via => :delete, :as => :destroy_account

  resources :accounts do
    collection do
      get 'index'
      get 'search'
      get 'sign_ups'
      get 'group_signups'
      post 'group_signup'
      get 'slot'
      get 'slip'
      get 'groupslip'
      post 'admin_writeup'
      post 'reset_writeup'
      post 'reset_feedback'
      post 'sign_up'
      post 'photoshoot'
      post 'reschedule'
      # get 'timeslots'
      get 'view_writeup'
      get 'add_writeup'
      get 'edit_info'
      get 'submit_writeup'
      post 'submit_final_writeup'
      get 'yearbook_preview'
      post 'addfeedback'
    end
  end

 

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
  get "*any", via: :all, to: "pages#not_found"
end
