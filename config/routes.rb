TicketHQ::Application.routes.draw do
  
  resources :tickets do
    get :related_tickets
    get :toggle_observe
    get :mod_rel_tickets
    collection do
      get :dynamic_statuses
    end
  end
  resources :records
  resources :projects do
    get :toggle_observe
    resources :tickets
  end
  
  match '/incoming_mails' => 'incoming_mails#create'
  
  match '/search' => 'tickets#advanced_search', :as => 'search'

  devise_for :users, :path_names => { :sign_in => 'login', 
    :sign_out => 'logout', 
    :sign_up => 'register' }, :controllers => { 
    :registrations => "registrations",
    :sessions => "sessions",
    :passwords => 'passwords'
  } do
    get "/login" => "sessions#new"
    get '/logout' => "sessions#destroy"
    get '/reset/password' => "passwords#edit"
  end

  resources :users, :only => [:index, :show]

  # 'admin', :controller => 'admin/panel'
  # Sample resource route within a namespace:
  namespace :admin do
		resources :projects do
		  collection do
		    get :new_status
		  end
		end   
		resources :groups, :users, :panel
	end

  root :to => "projects#index"

end
