Rails.application.routes.draw do
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'

  namespace :potepan do
    resources :products, param: :slug_or_id, only: [:show]
    resources :categories,                   only: [:show]
    resources :users
    resources :orders do
      member do
        get :step1, :step2, :step3, :complete
      end
    end
    get    '/login',                to: 'sessions#new'
    post   '/login',                to: 'sessions#create'
    delete '/logout',               to: 'sessions#destroy'
    get :/,                         to: 'home#index'
    get :index,                     to: 'home#index'
    get :unfinished,                to: 'home#unfinished'
    post :unfinished,               to: 'home#unfinished'
    get :about_us,                  to: 'sample#about_us'
    get :tokushoho,                 to: 'sample#tokushoho'
    get :privacy_policy,            to: 'sample#privacy_policy'
    post '/orders/:id/step1',       to: 'orders#data_set'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
