TicketHQ::Application.routes.draw do
  
  resources :tickets do
    get :related_tickets
    get :toogle_observe
    get :mod_rel_tickets
  end
  resources :records
  resources :projects do
    get :toogle_observe
    resources :tickets
  end
  
  match '/incoming_mails' => 'incoming_mails#create'
  
  match '/search' => 'tickets#advanced_search', :as => 'search'
  
  get '/toogle_closed_tickets' => 'tickets#toogle_closed_tickets', :as => "toogle_closed_tickets"

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
		resources :projects, :groups, :users, :panel
	end

  root :to => "projects#index"

end
