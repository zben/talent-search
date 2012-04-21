#encoding: UTF-8

class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_locale

    def authenticate!
        if !user_signed_in?
            flash[:notice]="请先登录"
            redirect_to new_user_session_path
        elsif current_user.profile.nil? && current_user.org_profile.nil?
            logger.info params[:info]
            logger.info params[:info]!='profile'
            if params[:info]!='profile' && params[:action]!='update'
              flash[:error]="请先填写以下基本信息,以便我们更好的了解您的需求。"
              redirect_to ind_user_new_path(current_user.id, 'profile') if current_user.is_a? IndUser
              redirect_to org_user_new_path(current_user.id, 'profile') if current_user.is_a? OrgUser
            end
        end
    end


    def after_sign_in_path_for(resource)
      if current_user._type=="IndUser"
        if current_user.profile
          ind_user_overview_path
        else
          ind_user_new_path(current_user.id,'profile')
        end
      else
        if current_user.org_profile
          org_user_job_posts_path(current_user.id)
        else
          org_user_new_path(current_user.id,'profile')
        end
      end
    end


    def set_locale
      I18n.default_locale = params[:locale] if params[:locale]
      I18n.locale = params[:locale] || I18n.default_locale
    end


    private

      def current_user_filter
        @user = User.find(params[:id])
        unless @user == current_user
          flash[:error] = "Permission denied."
          redirect_to root_path
        end
      end

end
