Rails.application.routes.draw do
  # 아래랑 동일 의미 get '/' => 'home#index'
  # get '/' => 'home#index'
  # post 'result' => 'home#result'

  # get 'plus/:num1/:num2' => 'home#plus'
  
  get '/index2' => 'home#index2'
  
  get '/write' => 'home#write'
  post '/create' => 'home#create'

  get '/modify/:post_id' => 'home#modify'
  post '/update/:id' => 'home#update'

  get 'delete/:id' => 'home#delete'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

