class PagesController < ApplicationController
  def home
    redirect_to IndUser.first
  end
  
  def landing
  end

end
