Rails.application.routes.draw do
  #Creating the routes specified for Schedules which is create, show, and destroy
  resources :schedules, only: [:create, :show ,:index,:destroy] do 
    #For appointments I placed the create route as well as the show and index routes so that they can be viewed.
    resources :appointments, only: [:index,:show,:create]
  end
end
