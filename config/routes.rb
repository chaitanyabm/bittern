Rails.application.routes.draw do
  get 'verify_acnt_details/email'

  get 'verify_acnt_details/phone'

  resources 'posts'

  # devise_for :users
  
    devise_for :users, controllers: {:omniauth_callbacks => "omniauth_callbacks", registrations: "users/registrations"}
      devise_scope :user do
      	 get '/users/sign_out' => 'devise/sessions#destroy'  
    		get 'signup/user_type' => 'users/registrations#select_user_type', :as => 'user_type'
	  end

    resources :users 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
