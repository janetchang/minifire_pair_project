class UrlsController < ApplicationController
  before_filter :log_impression, :only=> [:show]

  def index
    @urls = Url.without_users
  end

  def create
    if params[:url][:user_id]
      new_with_user
      desired_redirect = user_path(@user.username)
    else
      @url = Url.new(params[:url])
      desired_redirect = urls_path
    end
    
    @url.short_url = ('a'..'z').to_a.shuffle[0,4].join if @url.short_url == ""
    @url.impressions = 0
    if @url.save
      flash[:notice] = "Success!"
      redirect_to desired_redirect #need to change to users_user_id_urls_path
    else
      logger.info { "Errors: #{@url.errors.full_messages}" }
      logger.info { "User: #{@user}" }
      flash[:notice] = "Invalid URL. Original URL must include 'http' or 'https'. Short URL should be unique."
      @urls = @user.urls
      render 'users/show'
      # redirect_to desired_redirect #need to change to users_user_id_urls_path
    end
  end

  def show
    #@user = User.find_by_username(params[:username]) if params[:url][:user_id]
    redirect_to @url.orig_url
  end

  private
  def log_impression
    @url = Url.find_by_short_url(params[:short_url])
    @url.update_column(:impressions, @url.impressions+1)
    #update_attribute will change the timestamp of updated_at while update_column will not
  end

  def new_with_user
    @user = User.find(params[:url].delete(:user_id))
    @url = @user.urls.build(params[:url])
  end

end
