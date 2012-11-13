class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    @url.short_url = ('a'..'z').to_a.shuffle[0,4].join
    @url.save
    redirect_to new_url_path
  end

  def show
    @url = Url.find_by_short_url(params[:short_url])
    redirect_to "http://#{@url.orig_url}"
  end
end
