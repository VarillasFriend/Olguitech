Rails.application.routes.draw do
    scope "(:locale)", locale: /es|en/ do
        resources :newsletters
        resources :articles
        resources :proyectos
        resources :products
        resources :categories

        devise_for :users, :controllers => { registrations: 'registrations' }
        get '/user_index', to: 'users#index'

        devise_for :admins, :controllers => { registrations: 'admin_registrations' }

        resources :contactos
        get '/contacto', to: 'contactos#index'
        get '/contacto/new', to: 'contactos#new'
        
        get '/nosotros', to: 'nosotros#nosotros'

        root 'main#main'
    end

    get '/:locale' => 'main#main'
end