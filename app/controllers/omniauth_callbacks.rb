class OmniauthCallbacksController < Devise::OmniauthCallbacksController
skip_before_filter :verify_authenticity_token     
	
	def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

  if !@user.nil? and @user.persisted?
    #session["google_email"] = request.env["omniauth.auth"].info.email
    # session["google_profile_pic"] = request.env["omniauth.auth"].info.image
    #session["google_profile_name"] = request.env["omniauth.auth"].info.name
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    sign_in_and_redirect @user, :event => :authentication
  else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      flash.now[:error] = 'Please sign up before sign in through google+.'
      redirect_to sign_up_user_path(:id)
  end
  end

  def facebook
    
  @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

  if !@user.nil? and @user.persisted?
    
    session["facebook_email"] = request.env["omniauth.auth"].info.email
    session["facebook_profile_pic"] = request.env["omniauth.auth"].info.image
#    session["facebook_profile_name"] = request.env["omniauth.auth"].info.name
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
     #redirect_to sign_up_user_path(:id)
    sign_in_and_redirect @user
  else
      session["devise.facebook_uid"] = request.env["omniauth.auth"].except("extra")
      flash.now[:error] = 'Please sign up before sign in through facebook.'
      redirect_to sign_up_user_path(:id)
  end
  end



end


  