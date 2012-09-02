class PagesController < ApplicationController

  def home
    if current_user.is_a? IndUser
      redirect_to ind_user_overview_path
    elsif current_user.is_a? OrgUser
      redirect_to org_user_path(current_user)
    end
  end

  def landing
  end

  def referralbonus
  end

  def team
  end

  def jobs
  end

  def company
  end

  def contact
  end

  def services
  end
end
