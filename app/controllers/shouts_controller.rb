class ShoutsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @user = current_user
    if params[:type]=="follow"
      @shouts = @user.related_shouts(false).page(params[:page]).per(10)
    elsif params[:type]=="me"
      @shouts = @user.shouts.page(params[:page]).per(10)
    else
      @shouts = Shout.top_level.page(params[:page]).per(10)
    end
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
