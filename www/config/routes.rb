Rails.application.routes.draw do
  root 'pages#index'

  get 'pages/index'
  get 'select_jobs' => 'jobs#select_jobs', defaults: { format: 'json' }
  resources :jobs

end
