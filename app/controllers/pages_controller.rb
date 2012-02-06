class PagesController < ApplicationController

  def home
    if current_user.is_a? IndUser
      redirect_to default_jobs_path
    elsif current_user.is_a? OrgUser
      redirect_to org_user_path(current_user)
    else 
      redirect_to new_user_session_path
    end
  end
  
  def landing
  end

end
