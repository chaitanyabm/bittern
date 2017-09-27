class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    def after_sign_in_path_for(resource)
    if resource 
 		posts_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
