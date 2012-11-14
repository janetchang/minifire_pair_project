class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    @urls = @user.urls
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # redirect_to @user
      # redirect_to user_path(@user) #need to change to users_user_id_urls_path
      # redirect_to user_path(@user.id)
      redirect_to user_path(@user.username)
    else
      flash[:error] = "Sorry, this username is already taken."
      redirect_to new_user_path
    end
  end

end
