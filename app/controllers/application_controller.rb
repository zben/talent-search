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
      if current_user._type=="IndUser"
        if current_user.profile
          default_jobs_path
        else
          ind_user_new_path(current_user.id,'profile')
        end
      else
        if current_user.org_profile
          org_user_path(current_user.id)
        else
          org_user_new_path(current_user.id,'profile')
        end
      end
    end
    
    def after_sign_up_path_for(resource)
      flash[:notice]="感谢您的加入！请查收您的邮件确认。"
      new_user_session_path
    end
    
    def set_locale
      I18n.default_locale = params[:locale] if params[:locale]
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
