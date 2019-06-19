module Common
  extend ActiveSupport::Concern

  def client_new
    Twitter::REST::Client.new do |config|
      config.consumer_key = Settings.twitter.consumer_key
      config.consumer_secret = Settings.twitter.consumer_secret
      config.access_token = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
  end

end
