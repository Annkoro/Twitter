Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, except: [:create, :new] do
    resources :tweets
  end
end
