class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  helper_method :timeline, :test_bro
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

  def timeline
   play_library = []
    client = client_new
    client.home_timeline.each do |tweet|
      #if tweet include("#nowplaying")
        play_library.push("#{tweet.user.name} ID:@#{tweet.user.screen_name},  #{tweet.text}")
      #end
    end
    return play_library
  end
# max_idを引数にしてそれより過去のをさかのぼっていくのは＿

  def test_bro

  end



  def index
  end

  def show
  end

  def timeline_page
  end
end
