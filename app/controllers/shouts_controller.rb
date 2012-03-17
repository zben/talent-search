class ShoutsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @user = current_user
    @shouts = @user.related_shouts.page(params[:page]).per(10)
  end
  
  def create

    
    shout = Shout.create(params[:shout])
    current_user.shouts <<  shout
    shout.update_attribute(:message_with_link, highlight_link(shout.message))
    redirect_to :back
  end

  def destroy
    @shout = Shout.find(params[:id])
    @shout.destroy
    redirect_to :back
  end

end
