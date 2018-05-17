Rails.application.routes.draw do
  
  root 'pages#home'
  
  get 'pages/home'

  namespace :api do
    namespace :v1 do
      get 'stats/weight'
      get 'stats/height'
      get 'stats/table'
      post 'stats/confirm'
    end
  end
end
