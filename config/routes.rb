Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to:'posts#top', as: :top
  get '/sign_up', to:'users#sign_up', as: :sign_up
  post '/sign_up', to: 'users#sign_up_process'
  get '/sign_in', to:'users#sign_in', as: :sign_in
  post '/sign_in', to: 'users#sign_in_process'
  get '/new', to:'posts#new', as: :new_post
  resources :posts
  post '/new', to:'posts#create', as: :create
  resources :posts do
    member do
      post 'comment', to: 'posts#comment', as: :comment
    end
  end
  get '/posts/(:id)', to: 'posts#show', as: :show
  get	'/sign_out', to: 'users#sign_out', as: :sign_out
end