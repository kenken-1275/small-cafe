Rails.application.routes.draw do
  devise_for :users
  root to: 'shops#index' 
  namespace :admin do
    resources :announces,only:[:index,:new,:create,:edit,:update]
  end
  resources :shops ,only: [:index,:show] do
    collection do
      get :menu
      get :introduction
    end
  end
  resources :announces , only: :show
  resources :menus,only: :index
  resources :reserves, only:[:index,:new,:create] do
    collection do
      post :confirm
      get :back
    end
  end

end
