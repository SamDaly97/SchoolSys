Rails.application.routes.draw do
  get 'home/set_cookie'
  get 'home/show_cookie'
  get 'home/delete_cookie'
  get 'answers/index'
  get 'answers/show'
  get 'answers/new'
  get 'answers/edit'
  resources :problems do
    resources :answers
  end

  devise_for :teachers
  root to: 'pages#home'
  devise_for :users

  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_scope :teacher do
   get '/teachers/sign_out' => 'devise/sessions#destroy'
  end
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
