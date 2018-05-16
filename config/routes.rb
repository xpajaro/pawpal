Rails.application.routes.draw do
  
  root 'pages#home'
  
  get 'pages/home'

  get 'pages/report'

  namespace :api do
    namespace :v1 do
      get 'stats/weight'
      get 'stats/table'
      post 'stats/confirm'
    end
  end
end
