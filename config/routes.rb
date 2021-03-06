Rails.application.routes.draw do
  get 'log_in' => 'sessions#new', as: :log_in
  get 'log_out' => 'sessions#destroy', as: :log_out

  get "sign_up" => "users#new", as: :sign_up

  resources :users
  resources :sessions

  root to: 'tasks#index'
  resources :tasks, except: [:index, :show] do
    patch '/', action: :update_all, on: :collection
    get ':type', action: :index,
                 on: :collection,
                 as: :filtered,
                 constraints: { type: /open|done/ }
  end
end
