Talent::Application.routes.draw do




  resources :job_posts

  resources :organization_profiles

#  resources :exams

#  resources :educations

#  resources :experiences

#  resources :profiles

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users
  resources :ind_users
  resources :org_users
  
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
  
  match 'users/:id/new/:info'=>'users#new',:as=>'user_new'
  match 'users/:id/edit/:info'=>'users#edit',:as=>'user_edit'
  match 'users/:id/profile'=>'users#profile',:as=>'user_profile'
  
  match 'org_users/:id/jobs_posts'=>'org_users#job_posts',:as=>'org_user_job_posts'
  match 'ind_users/:id/jobs_posts'=>'ind_users#job_posts',:as=>'ind_user_job_posts'
  
  match 'skills/list'=>'skills#list',:as=>'skills_list'
  
  match 'bookmark/:type/:id'=>'bookmarks#bookmark', :as=>'bookmark'
  match 'unbookmark/:id'=>'bookmarks#unbookmark', :as=>'unbookmark'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :to => 'pages#home' 

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
