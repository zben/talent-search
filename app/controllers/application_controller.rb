class ApplicationController < ActionController::Base
    protect_from_forgery
  
    def authenticate!    
        unless user_signed_in?
            render "pages/landing"
        end
    end
    
    def after_sign_in_path_for(resource)
      if resource.profile
        user_path(resource.id)
      else
        user_new_path(resource.id,'profile')
      end
    end

end
