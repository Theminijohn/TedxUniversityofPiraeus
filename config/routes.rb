Tedxunipi::Application.routes.draw do

  devise_for :users
  get "pages/home"
  get "pages/about"


  # This is the Root Path for the Application
  root 'pages#home'

  get 'about' => 'pages#about'

  # Newsletter
  get 'newsletter' => 'newsletter#new'
  get "newsletter/success"
  get "newsletter/error"

  # Applications
  get 'applications' => 'pages#applications'

  # Schedule
  get 'schedule' => 'pages#schedule'

  # Team
  get 'team' => 'pages#team'

  # Speakers
  get 'speakers' => 'pages#speakers'


end
