Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#root'
  post '/missions/create', to: 'missions#create'
  get '/missions', to: 'missions#index'
  post '/missionstatus/update', to: 'missions#update_status'
end
