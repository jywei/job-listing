Rails.application.routes.draw do

  resources :preferred_candidates
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  namespace :admin do
    root 'home#index'
    # get 'categories' => 'categories#index'
    get   'companies' => 'companies#index'
    get   'edit_company/:id' => 'companies#edit'
    patch 'edit_company/:id' => 'companies#update'
    get   'article' =>          'article#index'
    post  'create_article' =>   'article#create_article'
    get   'job_filter' =>       'job_filter#index'
    get   'contact' =>          'contact#index'
    get   'delete_contact' =>   'contact#delete_contact'
    get   'seeker' =>           'seeker#index'
    get   'edit_seeker/:id' =>  'seeker#edit'
    patch 'edit_seeker/:id' =>  'seeker#update'
    get   'getCompany' =>       'companies#getCompany'
    get   'getData' =>          'job_filter#getData'
    get   'addFilter' =>        'job_filter#addFilter'
    get   'deleFilter' =>       'job_filter#deleFilter'
    resources :categories
    resources :industries
  end

  root 'pages#index'


  get 'pages/index'
  get 'pages/contact_us' => 'pages#contact_us'
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

  get 'new_cover_letter' => 'jobs#new_cover_letter'
  post 'cover_letters' => 'jobs#cover_letter'

  get 'show_cover_letter/:id' => 'jobs#show_cover_letter'

  get 'blogs'     => 'blog#index'
  get 'blogs/:id' => 'blog#show'

  resources :jobs
  resources :resumes
  resources :companies

end
