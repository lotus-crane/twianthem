class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  include Common
  require 'twitter'

  #def tweet
  #  client = client_new
  #  client.update(params[:text])
  #  redirect_to home_path
  #end

  #def timeline_page
    #client = client_new
    #@user = client.user
    #@tweets = client.home_timeline(include_entities: true)
  #end

  #def timeline_page
  #  @play_library = []
  #  client = client_new
  #  client.home_timeline.each do |tweet|
    #  if tweet include("#nowplaying")
      #  @play_library.push("\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]\e[0m" + tweet.text)
    #  end
  #  end
  #end



  def index
  end

  def show
  end

  def timeline_page
  end
end
