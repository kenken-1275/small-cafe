Rails.application.routes.draw do
root to: 'shops#index' 
resources :shops ,only: [:index,:show]

end
