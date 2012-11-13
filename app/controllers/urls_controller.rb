class UrlsController < ApplicationController
  before_filter :log_impression, :only=> [:show]

  def index
    @urls = Url.all
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    @url.short_url = ('a'..'z').to_a.shuffle[0,4].join
    @url.impressions = 0
    if @url.save
      flash[:notice] = "Success!"
      redirect_to urls_path
    else
      flash[:notice] = "Invalid URL"
      redirect_to urls_path
    end
  end

  def show
    redirect_to @url.orig_url
  end

  private
  def log_impression
    @url = Url.find_by_short_url(params[:short_url])
    @url.update_column(:impressions, @url.impressions+1)
    #update_attribute will change the timestamp of updated_at while update_column will not
  end
end
