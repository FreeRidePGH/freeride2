def resources_project_work_log
  resources :work_log, :path_names => {:new => 'enter'}, :only => [:new, :create],
  :controller=>'project_time_entries'
end

BikeBinder::Application.routes.draw do

  # Note:  See all routes with "rake routes"

  resources :programs, :except => [:destroy] do
    resources :bikes, :only => [:index]
  end

  # access to projects without nesting in programs
  resources :projects, \
  :only => [:show, :edit, :update, :create, :new, :delete, :destroy], \
  :path_names => {:new=>'start', :delete=>'cancel'} do
    member do
      post 'new_comment'
      put 'transition'
      get 'finish'
      put 'close'
    end

    resources_project_work_log
  end

  resources :project_categories, :except=>[:destroy, :new, :create, :index] do
    resources :bikes, :only => [:index]
  end

  devise_for :users

  resources :bikes,:except => [:destroy] do
    member do
      post 'new_comment'
      put 'vacate_hook'
      put 'reserve_hook'
      put 'assign_program'
      put 'change_hook'
      get 'depart'
      get 'get_models'
    end
  end
  

  resources :hooks,:except =>[:destroy, :new, :create]

  # Search routes
  resources :searches, :only => [:index]
  match '/searches/browse' => 'searches#browse', :as => :browse

  # Mobile routes
  resources :mobile, :only => [:index]
  match '/mobile/filter_bikes' => 'mobile#filter_bikes', :via => [:get]
  match '/mobile/home' => 'mobile#home'
  match '/mobile/find' => 'mobile#find'
  match '/mobile/add' => 'mobile#add'
  match '/mobile/show/:id' => 'mobile#show', :id => Bike.number_pattern
  match '/mobile/findsubmit' => 'mobile#find_submit'
  match '/mobile/generate_code/:id' => 'mobile#generate_code'
  match '/mobile/upload' => 'mobile#upload', :via => [:get,:post]
  match '/mobile/ajax_show/:id' => 'mobile#ajax_show'
  match '/mobile/ajax_find' => 'mobile#ajax_find', :via => :get
  match '/mobile/ajax_add' => 'mobile#ajax_add', :via => :get

  # Ensure root is set per recommendations when installing Devise
  root :to => 'bikes#index', :via => [:get]

  # Map top level domain seach to bikes and hooks
  match '/:id' => 'bikes#show', :id => Bike.number_pattern, :via => [:get]
  match '/:id' => 'hooks#show', :id => Hook.number_pattern, :via => [:get]

  # AJAX Routes
  match '/bikes/get_models/:brand_id' => 'bikes#get_models'
  match '/bikes/get_brands/:bike_model_id' => 'bikes#get_brands'
  match '/bikes/filter_bikes/:id' => 'bikes#filter_bikes'
  match '/bikes/get_details/:id' => 'bikes#get_details'
end
