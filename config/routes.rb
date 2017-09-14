Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#root'
  post '/missions/create', to: 'missions#create'
  get '/missions', to: 'missions#index'
  post '/missionstatus/update', to: 'missions#update_status'

  post '/notifications/create', to: 'notifications#create'

  post '/push_tokens/create', to: 'push_tokens#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
