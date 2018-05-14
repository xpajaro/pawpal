Rails.application.routes.draw do
  
  root 'pages#home'
  
  get 'pages/home'

  get 'pages/report'

  get 'pages/stats'

end
