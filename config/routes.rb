LolcommitServer::Application.routes.draw do
  resources :git_commits
  resources :animated_gifs, :only => :create

  match '/auth/:provider/callback', :to => 'sessions#create', :as => 'auth_callback'
  match '/auth/github', :as => 'auth_github'
  resource :sessions, :only => [:destroy]

  root :to => "main#index"
end
