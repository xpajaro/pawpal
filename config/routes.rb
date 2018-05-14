Rails.application.routes.draw do
  resources :height_stats
  resources :weight_stats
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
