Rails.application.routes.draw do
  constraints subdomain: "development" do
    devise_for :admins, path: '', path_names: { sign_in: '', sign_out: ''}
  end
  #get 'statics/index'
  root to: "statics#index"
  get 'home', to: "statics#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
