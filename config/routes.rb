Rails.application.routes.draw do
  resources :post_images
  devise_for :admins, controllers: {passwords: 'admins/passwords'}

  devise_for :users

  resources :admins do
    member do
      post 'regenerate_admin_password'
    end
  end

  resources :users do
    member do
      post 'regenerate_user_password'
      get 'results', to: 'results#user_list'
    end
  end

  resources :pickup_requests, except: [:new] do
    member do
      put 'change_state', to: 'pickup_requests#change_state'
    end
  end

  get 'send_pickup_request', to: 'pickup_requests#new', as: 'new_pickup_request'
  get 'pickup_requests/list/:user_id', to: 'pickup_requests#list'
  delete '/user_pickup_requests/:id', to: 'pickup_requests#user_destroy'

  resources :appointments, except: [:index, :show] do
    member do
      put 'change_state', to: 'appointments#change_state_admin'
      put 'user_cancellation', to: 'appointments#change_state_user'
    end
  end
  get 'appointments/confirmed', to: 'appointments#index', defaults: {status: Appointment::CONFIRMED}
  get 'appointments/canceled', to: 'appointments#index', defaults: {status: Appointment::CANCELED}
  get 'appointments/completed', to: 'appointments#index', defaults: {status: Appointment::COMPLETED}
  get 'appointments/list/:user_id', to: 'appointments#list'

  resources :results, except: [:update]

  get 'results/list/:user_id', to: 'results#list', as: 'result_list'
  get 'results/download/:result_id', to: 'results#download_file', as: 'download_result'

  resources :labs do
    get 'time_ranges', to: 'time_ranges#list'
    post 'time_ranges/new', to: 'time_ranges#create'
    member do
      get 'availability', to: 'labs#lab_availability', as: 'lab_availability'
    end
  end

  resources :time_ranges, only: [:destroy]
  resources :posts
  get 'news/:page', to: 'posts#list', as: "all_posts"
  get 'news/category/:category_id', to: 'posts#list_by_category', as: "category_posts"
  get 'news/tag/:tag_id', to: 'posts#list_by_tag', as: "tag_posts"
  resources :tags
  resources :categories
  get 'contact', to:'landing#contact',as:"contact"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'
  get '/admin', to: 'landing#index_admin', as: 'admin_index'
  get ":url" => "application#redirect_user", :constraints => { :url => /.*/ }
end
