class UsersController < ApplicationController
  before_filter :authenticate!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new 
    @user = User.find(params[:id])
    render "users/edit/#{params[:info]}"
  end
 
  
  def edit
    @user = User.find(params[:id])
    render "users/edit/#{params[:info]}"
  end

  def update
     @user =  User.find(params[:id])
     @user.update_attributes(params[:user])
     redirect_to :back
  end
end
