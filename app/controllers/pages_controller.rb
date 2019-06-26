class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  helper_method :timeline, :login_user
  include Common
  require 'twitter'


  def timeline
    TweetGetJob.perform_now(session[:oauth_token], session[:oauth_token_secret])


  #play_library = []
  #client = client_new
  #client.update(
  #  "ハッシュタグ:nowplayingのツイート取得を開始します! #twi_test "
  #  )
    #count = 0
    #loop do
    #  client.home_timeline({ count: 10}).each do |tweet|
    #    #大文字小文字の区別を付けたくないため以下ではダメ
    #    #if tweet.text.include?("#nowplaying")
    #    tweet.text.match(/#nowplaying/i) do |f|
    #      if tweet.text.include?("RT @")
    #      else
    #        play_library.push("#{tweet.text}")
    #      end
    #    end
    #  end
    #  play_library.each do |text|
    #    nowplaydata = NowplayDatum.new
    #    text.gsub!("#nowplaying", "")
    #    text.gsub!(/\n.+/,"")
    #    text.gsub!(" - ", "@|@")
    #    text.gsub!(" / ", "@|@")
    #    text.gsub!(" by ","@|@")
    #    bunkatu = text.split("@|@")
    #    bunkatu.each do |data|
    #      nowplaydata.artist = bunkatu[1]
    #      nowplaydata.song = bunkatu[0]
    #      nowplaydata.user_id = client.user.screen_name
    #      nowplaydata.save
    #    end
    #  end
    #  count += 1
      #client.update(
        #{}"sleep(120)#{count} #twi_test"
        #)
      #sleep(120)
    #end
  end


  def login_user
    begin
      client = client_new
      @user = client.user
      return @user
      rescue Twitter::Error::TooManyRequests => error
        flash[:tmr] = "API制限に達してしまいました…15分ほど経ってから再度お試しください"
      end
    end
  end




  def index
  end

  def show
  end

  def timeline_page
  end
