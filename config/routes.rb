Rails.application.routes.draw do
  #controlar versiones -> usando namespaces
  #get "/", to: "welcome#root" #controlador#action
  #darle versiones a nuestra API, agregando namcespaces
  # especificamos que todas las peticiones que vayan a /api/ el formato
  #por default con el que responda sea json
  namespace :api, defaults: { format: "json" } do 
    #primera version de API
    namespace :v1 do
      resources :users
    end
    #namespace :v2 do # para manejar otra version sin romper la anterior
    #  resources :users
    #end
  end
end
