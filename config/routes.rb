Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :line_items do
    post 'decrement', on: :member
  end

  resources :orders do
    post 'ship_order', on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
end
