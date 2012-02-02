class PagesController < ApplicationController
  before_filter :authenticate!
  def home
    redirect_to current_user
  end
  
  def landing
  end

end
