LolcommitServer::Application.routes.draw do
  resources :git_commits
  resources :animated_gifs, :only => :create
end
