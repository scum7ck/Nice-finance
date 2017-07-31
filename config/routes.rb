Rails.application.routes.draw do
  devise_for :users

  get 'search_stocks', to: 'stocks#search'
  
	root 'users#my_portfolio'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
