class UrlsController < ApplicationController
  before_filter :load_urls, :only => [:create, :index]
  after_filter :log_impression, :only => :show

  def index
  end

  def create
    @url = Url.new params[:url]
    puts @url.valid?
    puts @url.errors.full_messages
    if @url.save
      handle_redirection
    else
      render :index
    end
  end

  def show
    @url = Url.find_by_short_url(params[:short_url])
    redirect_to @url.orig_url
  end

  private

  def handle_redirection
    if @url.user.present?
      redirect_to user_path(@url.user.username)
    else
      redirect_to urls_path
    end 
  end

  def load_urls
    @urls = Url.without_users
  end

  def log_impression
    @url.log_impression!
  end
end
