Rails.application.routes.draw do
  root 'static_pages#top'
  get 'static_pages/notification', to: 'static_pages#notification'
  resources :menus do
    collection do
      get :treatment_menu #ユーザーメニュー一覧画面
    end
  end
  resources :reservations do
    resources :reviews
    collection do
      get :management_new
      get :search
      get :confirm_reservation
      get :reservation_management
      post :reservation_management_create
    end
    member do
      get :edit_reserve
      post :update_reserve
    end
  end
  resources :stores
  get 'users/account', to: 'users#account'
  get 'users/index', to: 'users#index'
  get 'users/search', to: 'users#search'
  get 'users/show', to: 'users#show'
  get 'users/admin_new', to: 'users#admin_new'
  post 'users/admin_create', to: 'users#admin_create'
  get 'users/admin_edit', to: 'users#admin_edit'
  patch 'users/admin_update', to: 'users#admin_update'
  delete 'users/admin_destroy', to: 'users#admin_destroy'
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: "omniauth_callbacks"
  }
  scope modules: :users do
    resource :users,only: [:edit, :update, :show] do
      collection do
        get 'quit' # 退会画面
        patch 'out' # flagを更新し、会員からはログインできなくする
      end
    end
  end
  get 'staffs/account', to: 'staffs#account'
  get 'staffs/index', to: 'staffs#index'
  get 'staffs/search', to: 'staffs#search'
  get 'staffs/show', to: 'staffs#show'
  get 'staffs/admin_new', to: 'staffs#admin_new'
  post 'staffs/admin_create', to: 'staffs#admin_create'
  get 'staffs/admin_edit', to: 'staffs#admin_edit'
  patch 'staffs/admin_update', to: 'staffs#admin_update'
  delete 'staffs/admin_destroy', to: 'staffs#admin_destroy'
  devise_for :staffs, controllers: {
    sessions:      'staffs/sessions',
    passwords:     'staffs/passwords',
    registrations: 'staffs/registrations'
  }
  resources :reservations
  resources :stores
  resources :items do
    collection do
      get 'search'
    end
  end
  resources :events do
    collection do
      get 'search'
    end
  end
  resource :carts, only: %i[show]

  resources :orders, only: %i[index destroy]
  post 'create_item_order', to: 'orders#create_item_order'
  delete 'destroy_item_order', to: 'orders#destroy_item_order'
  post 'ship_item_order', to: 'orders#ship_item_order'
  post 'cancel_ship_item_order', to: 'orders#cancel_ship_item_order'

  resources :event_orders, only: %i[index destroy]
  post 'create_event_order', to: 'event_orders#create_event_order'
  delete 'destroy_event_order', to: 'event_orders#destroy_event_order'
  post 'ship_event_order', to: 'event_orders#ship_event_order'
  post 'cancel_ship_event_order', to: 'event_orders#cancel_ship_event_order'
  
  resources :payments, only: %i[index show]
  resources :purchase_records, only: %i[index show]
  post 'pay', to: 'payments#pay'
  resources :notifications
end
