class TweetGetJob < ApplicationJob
  queue_as :default


  def perform(token, secret)
    # Do something later
    client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_KEY']
        config.consumer_secret = ENV['TWITTER_SECRET']
        config.access_token = token
        config.access_token_secret = secret
    end
    @user_screen_name = client.user.screen_name
    client.update(
      "ハッシュタグ:nowplayingのツイート取得を開始します! #twi_test "
    )
    tweet_ids = []
    count = 0
    loop do
      begin
        sleep(20)
        play_library = []
          client.home_timeline.each do |tweet|
            #大文字小文字の区別を付けたくないため以下ではダメ
            #if tweet.text.include?("#nowplaying")
            tweet.text.match(/#nowplaying/i) do |f|
              if tweet.text.include?("RT @")
              else
                if tweet_ids.include?("#{tweet.id}")
                else
                  tweet_ids.push("#{tweet.id}")
                  play_library.push("#{tweet.text}")
                end
              end
            end
          end
        rescue Twitter::Error::TooManyRequests => error
          sleep error.rate_limit.reset_in
        retry
      end
    #  end
      count += 1
      client.update("一次処理終わり #{count}")
      play_library.each do |text|
        nowplaydata = NowplayDatum.new
        text.gsub!("#nowplaying", "")
        text.gsub!(/\n.+/,"")
        text.gsub!(" - ", "@|@")
        text.gsub!(" / ", "@|@")
        text.gsub!(" by ", "@|@")
        text.gsub!(/https:.+/, "")
        bunkatu = text.split("@|@")
        bunkatu.each do |data|
          nowplaydata.artist = bunkatu[1]
          nowplaydata.song = bunkatu[0]
          nowplaydata.user_id = @user_screen_name
          nowplaydata.save
        end
      end
      sleep(90)
    end
  end
end
