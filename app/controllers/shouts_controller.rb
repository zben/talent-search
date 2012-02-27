class ShoutsController < ApplicationController
  include ApplicationHelper
  
  def index
    relevant_user_ids = current_user.bookmarked(['IndUser','OrgUser']).map(&:id).push(current_user.id)
    @shouts = Shout.desc(:created_at).where(:user_id.in=>relevant_user_ids).page(params[:page]).per(10)
    
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
