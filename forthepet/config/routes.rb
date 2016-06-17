Forthepet::Application.routes.draw do

  root to: 'products#index'
  mount_roboto

  resources :products, only: [:index, :show], path: 'product' do
    collection do
      get 'dog'
      get 'cat'
      get 'misc'
    end
  end

  get '/how-it-works', to: 'static_pages#how_it_works'
  get '/about', to: 'static_pages#about'
  get '/legal', to: 'static_pages#legal', as: 'legal'
  get '/return-policy', to: 'static_pages#return_policy', as: 'return_policy'
  get '/privacy-policy', to: 'static_pages#privacy_policy', as: 'privacy_policy'
  get '/product-disclaimers', to: 'static_pages#product_disclaimers', as: 'product_disclaimers'
  get '/copyright-notice', to: 'static_pages#copyright_notice', as: 'copyright_notice'
  get '/shipping-information', to: 'static_pages#shipping_information', as: 'shipping_information'
  get '/purchase-terms-and-conditions', to: 'static_pages#purchase_terms_and_conditions', as: 'purchase_terms_and_conditions'
  get '/checkout-payment-process', to: 'static_pages#checkout_payment_process', as: 'checkout_payment_process'

  devise_for :users, path: '', path_names: { sign_in: 'sign-in', sign_out: 'sign-out', sign_up: 'sign-up' }

  namespace :account do
    root to: 'account#index'

    resources :profile, only: [:index, :update]
    resources :orders
    resources :billing_addresses, only: [:create, :update]
    resources :shipping_addresses, only: [:create, :update]
    resources :update_password, only: [:update]
  end

  resources :mailing_list, only: [:index, :create], path: 'subscriptions'
  resources :referrals, only: [:index, :show]

  scope module: 'shopping' do
    resources :checkout
    resources :cart, only: [:index, :update]
    resources :cart_items
    post 'cart_items/create_variant', to: 'cart_items#create_variant'
  end

  devise_for :admins, controllers: {sessions: 'admin/sessions'}, path: 'admin', path_names: { sign_in: 'sign-in' }

  namespace :admin do
    root to: 'admin#index'

    resources :product_wizard, path: 'product-wizard'

    resources :orders, only: [:index, :show] do
      post '/email', to: 'orders#email'
    end

    resources :order_summaries, only: [:index], path: 'order-summaries'
    post 'order_summaries/email', to: 'order_summaries#email'

    resources :order_processing, param: 'order_id', only: [:index, :show], path: 'order-processing'
    patch 'order-processing/:order_id/tracking_no', to: 'order_processing#tracking_no', as: 'order_processing_tracking_no'
    patch 'order-processing/:order_item_id/received', to: 'order_processing#received', as: 'order_processing_received'
    patch 'order-processing/:order_item_id/shipping', to: 'order_processing#shipping', as: 'order_processing_shipping'
    put 'order-processing/:order_id/ship-it', to: 'order_processing#ship_it', as: 'order_processing_ship_it'

    resources :suppliers

    resources :product, path: 'products' do
      post 'clone'

      resources :product_option, only: [:index, :update], path: 'options', as: 'options'
      resources :product_supplier, only: [:index, :create], as: 'suppliers', path: 'suppliers'
      resources :variant, as: 'variants'

      resources :product_categories, only: [:index, :create], path: 'categories', as: 'categories'
      resources :product_images, only: [:index, :create, :destroy], path: 'images', as: 'images'
      resources :product_features, only: [:index, :create, :destroy], path: 'features', as: 'features'
    end

    post '/variants/sort', to: 'variant#sort'
    post '/images/sort', to: 'product_images#sort'
    post '/option-values/sort', to: 'option_value#sort'

    resources :option do
      resources :option_value, path: 'values'
    end

    resources :category
    resources :fine_prints, as: 'fine_prints', path: 'fine-prints'

    resources :users do
      resources :user_addresses, only: [:index, :update, :create], path: 'addresses', as: 'addresses'
      resources :user_password, only: [:index, :update, :create], as: 'password', path: 'password'
      resources :user_credits, only: [:index, :update], as: 'credits', path: 'credits'
    end

    post 'users/logout_and_register', to: 'users#logout_and_register', path: 'users/logout_and_register'

    resources :admins do
      resources :admin_password, only: [:index, :create], as: 'password', path: 'password'
    end
  end
end
