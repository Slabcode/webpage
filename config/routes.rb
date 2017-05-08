Rails.application.routes.draw do
  devise_for :admins, path: ''
  #get 'statics/index'
  root to: "statics#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
