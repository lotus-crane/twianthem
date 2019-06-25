class AnthemViewController < ApplicationController
  def anthem_view
    client_new = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.access_token = session[:oauth_token]
        config.access_token_secret = session[:oauth_token_secret]
      end
    @user_id_data = NowplayDatum.where(user_id: client_new.user.screen_name)
  end
end
