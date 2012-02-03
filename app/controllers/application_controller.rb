#encoding: UTF-8

class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_locale
 
    def authenticate!    
        unless user_signed_in?
            flash[:notice]="请先登录"
            redirect_to new_user_session_path
        end
    end
    
    def after_sign_in_path_for(resource)
      puts "USER CLASS"
      puts current_user.class
      if current_user.class.name=="IndUser"
        if current_user.profile
          user_path(current_user.id)
        else
          user_new_path(current_user.id,'profile')
        end
      else
        if current_user.org_profile
          user_path(current_user.id)
        else
          user_new_path(current_user.id,'profile')
        end
      end
    end
    
    
    def set_locale
      I18n.default_locale = params[:locale] if params[:locale]
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
