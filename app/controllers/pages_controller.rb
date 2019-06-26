class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  helper_method :timeline, :login_user, :killthread, :threads_start
  include Common
  require 'twitter'
  @@threads = []


  def timeline
    TweetGetJob.perform_now(session[:oauth_token], session[:oauth_token_secret])
  end

  def killthread
    @@threads.each do |t|
      Thread.kill(t)
    end
    flash[:kill] = "スレッドを終了しました"
    redirect_to root_path
  end

  def threads_start
     @@threads << Thread.new {timeline()}
     flash[:get_start] = "なうぷれの取得を開始しました！"
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
