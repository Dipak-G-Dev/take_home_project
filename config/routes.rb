Rails.application.routes.draw do
  root 'profile_scrappers#new'

  get 'profile_scrappers/new'
  post 'profile_scrappers/create'
  post 'scrape', to: 'profile_scrappers#scrape'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
