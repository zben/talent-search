# encoding: UTF-8

# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    if params[:invitation_code]!="12345"
      flash[:notice] = "邀请码不正确"
      redirect_to :action=>:new 
    else
      super
    end
  end

  def update
    super
  end
end 
