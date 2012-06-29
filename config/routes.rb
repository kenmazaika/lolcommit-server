LolcommitServer::Application.routes.draw do
  get '/git_commits/gif', :to => 'git_commits#gif'
  resources :git_commits
end
