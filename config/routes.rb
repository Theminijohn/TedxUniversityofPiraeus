Tedxunipi::Application.routes.draw do

  resources :ideas

  resources :applications

  get "users/show"
  # Devise Settings
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                      :registrations => "registrations"},
             :path => '', :path_names => {:sign_in => 'signin'}

  get "pages/home"
  get "pages/about"


  # This is the Root Path for the Application
  root 'pages#home'

  get 'about' => 'pages#about'

  # Newsletter
  get 'newsletter' => 'newsletter#new'
  get "newsletter/success"
  get "newsletter/error"

  # Schedule
  get 'schedule' => 'pages#schedule'

  # Team
  get 'team' => 'pages#team'

  # Speakers
  get 'speakers' => 'pages#speakers'

  # User Page
  get 'users/:id' => 'users#show', as: :user

  # Talks
  get 'talks' => 'pages#talks'

  # Submit an Application
  get 'submit' => 'pages#submit'

  get 'youridea' => 'pages#youridea'


end
