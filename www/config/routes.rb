Rails.application.routes.draw do


  devise_for :users
  namespace :admin do
    root 'home#index'
    # get 'categories' => 'categories#index'
    get 'job_filter' => 'job_filter#index'
    get 'getData' => 'job_filter#getData'
    get 'addCate' => 'job_filter#addCate'
    get 'deleCate' => 'job_filter#deleCate'
    resources :categories
    resources :industries
  end

  root 'pages#index'

  get 'pages/index'
  get 'select_jobs' => 'jobs#select_jobs', defaults: { format: 'json' }
  resources :jobs

end
