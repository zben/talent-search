class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_locale
 
    def authenticate!    
        unless user_signed_in?
            redirect_to new_user_session_path
        end
    end
    
    def after_sign_in_path_for(resource)
      if resource.profile
        user_path(resource.id)
      else
        user_new_path(resource.id,'profile')
      end
    end
    
    
    def set_locale
      I18n.default_locale = params[:locale] if params[:locale]
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
