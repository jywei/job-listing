Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  namespace :admin do
    root 'home#index'
    # get 'categories' => 'categories#index'
    get 'companies' => 'companies#index'
    get 'getCompany' => 'companies#getCompany'
    get 'job_filter' => 'job_filter#index'
    get 'getData' => 'job_filter#getData'
    get 'addFilter' => 'job_filter#addFilter'
    get 'deleFilter' => 'job_filter#deleFilter'
    resources :categories
    resources :industries
  end

  root 'pages#index'

  get 'pages/index'
  get 'which_role' => 'pages#which_role'
  get 'select_jobs' => 'jobs#select_jobs', defaults: { format: 'json' }

  resources :jobs
  resources :resumes
  resources :companies

end
