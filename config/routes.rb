Rails.application.routes.draw do
  devise_for :users
  root to: 'shops#index' 
  namespace :admin do
    resources :announces,only:[:index,:new,:create,:edit,:update,:destroy]
    resources :reserves
  end
  resources :shops ,only: [:index,:show] do
    collection do
      get :menu
      get :introduction
    end
  end
  resources :announces , only: :show
  resources :menus,only: :index
  resources :reserves, only:[:index,:new,:create,:destroy] do
    collection do
      post :confirm
      get :back
      get :cancel_confirm
    end
  end
  namespace :api do
    resources :reservation_times,only: :index
    resources :reservation_people_numbers,only: :index
  end

end
