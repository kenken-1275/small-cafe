Rails.application.routes.draw do
  devise_for :users
root to: 'shops#index' 
namespace :admin do
  resources :announces,only:[:index,:new,:create,:edit,:update]
end
resources :shops ,only: [:index,:show]
resources :announces , only: :show
resources :menus,only: :index
resorces :reserves, only:[:index]

end
