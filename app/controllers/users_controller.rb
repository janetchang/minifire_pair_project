class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    redirect_to(root_path, :notice => "we don't know who you are") and return unless @user.present?
    @urls = @user.urls
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user.username)
    else
      redirect_to new_user_path, :error => "Sorry, this username is already taken."
    end
  end

  def login
    redirect_to user_path(params[:username])   
  end
end
