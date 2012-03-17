Talent::Application.routes.draw do




  resources :job_posts

  resources :organization_profiles

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users
  resources :ind_users
  resources :org_users
  resources :shouts
  
  match 'overview' => 'ind_users#show', :as=>'ind_user_overview'
  match 'job_searches/default'=>'job_searches#show',:as=>'default_jobs'
  match 'talent_searches/default'=>'talent_searches#show',:as=>'default_talent'
  resources :job_searches

  resources :talent_searches
  match 'ind_users/:id/new/:info'=>'ind_users#new',:as=>'ind_user_new'
  match 'ind_users/:id/edit/:info'=>'ind_users#edit',:as=>'ind_user_edit'
  match 'ind_users/:id/profile'=>'ind_users#profile',:as=>'ind_user_profile'
  
  match 'bookmarked/ind/users'=>'ind_users#bookmarked_users', :as=>"bookmarked_users"
  match 'bookmarked/org/users'=>'org_users#bookmarked_users', :as=>"bookmarked_users_for_companies"
  match 'bookmarked/companies'=>'ind_users#bookmarked_companies', :as=>"bookmarked_companies"
  match 'bookmarked/jobs'=>'ind_users#bookmarked_jobs', :as=>"bookmarked_jobs"
  
  
  match 'org_users/:id/new/:info'=>'org_users#new',:as=>'org_user_new'
  match 'org_users/:id/edit/:info'=>'org_users#edit',:as=>'org_user_edit'
  match 'org_users/:id/profile'=>'org_users#profile',:as=>'org_user_profile'
  
  match 'users/:id/update/account'=>"users#update_email_or_password",:as=>'user_update_email_or_password'
  match 'users/:id/new/:info'=>'users#new',:as=>'user_new'
  match 'users/:id/edit/:info'=>'users#edit',:as=>'user_edit'
  match 'users/:id/profile'=>'users#profile',:as=>'user_profile'
  
  match 'org_users/:id/jobs_posts'=>'org_users#job_posts',:as=>'org_user_job_posts'
  match 'ind_users/:id/jobs_posts'=>'ind_users#job_posts',:as=>'ind_user_job_posts'
  
  match 'skills/list'=>'skills#list',:as=>'skills_list'
  
  match 'bookmark/:type/:id'=>'bookmarks#bookmark', :as=>'toggle_bookmark'


  root :to => 'pages#home' 
  
end
