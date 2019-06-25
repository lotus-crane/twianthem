class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  helper_method :timeline, :login_user
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
  #{tweet.user.name} ID:@#{tweet.user.screen_name},
  redirect_to root_path
  play_library = []
  client = client_new
  client.update(
    "ハッシュタグ:nowplayingのツイート取得を開始します! #twi_test "
    )
    #count = 0
    #loop do
      client.home_timeline({ count: 10}).each do |tweet|
        #大文字小文字の区別を付けたくないため以下ではダメ
        #if tweet.text.include?("#nowplaying")
        tweet.text.match(/#nowplaying/i) do |f|
          if tweet.text.include?("RT @")
          else
            play_library.push("#{tweet.text}")
          end
        end
      end
      play_library.each do |text|
        nowplaydata = NowplayDatum.new
        text.gsub!("#nowplaying", "")
        text.gsub!(/\n.+/,"")
        text.gsub!(" - ", "@|@")
        text.gsub!(" / ", "@|@")
        text.gsub!(" by ","@|@")
        bunkatu = text.split("@|@")
        bunkatu.each do |data|
          nowplaydata.artist = bunkatu[1]
          nowplaydata.song = bunkatu[0]
          nowplaydata.user_id = client.user.screen_name
          nowplaydata.save
        end
      end
    #  count += 1
      #client.update(
        #{}"sleep(120)#{count} #twi_test"
        #)
      #sleep(120)
    #end
  end


  def login_user
    client = client_new
    @user = client.user
    return @user
  end




  def index
  end

  def show
  end

  def timeline_page
  end
end
