LolcommitServer::Application.routes.draw do
  resources :git_commits do
    get :latest_commits, on: :collection
  end

  resources :animated_gifs, :only => :create
  resources :repos

  get  '/auth/:provider/callback', :to => 'sessions#create', :as => 'auth_callback'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get  '/auth/github', :as => 'auth_github'
  resource :sessions, :only => [:destroy]
  resource :users, :only => [] do
    get 'account'
  end
  resources :users, :only => :show

  root :to => "main#index"
end
