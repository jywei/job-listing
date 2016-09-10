Rails.application.routes.draw do

  resources :preferred_candidates
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
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
  get 'resumes/education' => 'resumes#education'
  get 'resumes/experience' => 'resumes#experience'
  get 'resumes/getEdu' => 'resumes#getEdu'
  get 'resumes/addSch' => 'resumes#addSch'
  get 'resumes/addLan' => 'resumes#addLan'
  get 'resumes/addSki' => 'resumes#addSki'
  get 'resumes/deleEdu' => 'resumes#deleEdu'
  get 'resumes/getExp' => 'resumes#getExp'
  get 'resumes/addExp' => 'resumes#addExp'
  get 'resumes/addDJS' => 'resumes#addDJS'
  get 'resumes/addDJR' => 'resumes#addDJR'
  get 'resumes/addDJI' => 'resumes#addDJI'
  get 'resumes/deleExp' => 'resumes#deleExp'

  get 'companies/save_to_favorites' => 'companies#save_to_favorites', as: :save_to_favorites
  get 'companies/unlike' => 'companies#unlike', as: :unlike

  get 'jobs/favorite_job' => 'jobs#favorite_job', as: :favorite_job
  get 'jobs/unfollow_job' => 'jobs#unfollow_job', as: :unfollow_job

  get 'resumes/favorite_resume' => 'resumes#favorite_resume', as: :favorite_resume
  get 'resumes/unfollow_resume' => 'resumes#unfollow_resume', as: :unfollow_resume

  get 'dashboard' => 'resumes#dashboard'

  patch 'user_update' => 'resumes#user_update'

  resources :jobs
  resources :resumes
  resources :companies

end
