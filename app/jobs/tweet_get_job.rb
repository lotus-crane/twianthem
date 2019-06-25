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
    play_library = []

    client.update(
      "ハッシュタグ:nowplayingのツイート取得を開始します! #twi_test "
    )
    count = 0
    loop do
    #  begin
        client.home_timeline.each do |tweet|
          #大文字小文字の区別を付けたくないため以下ではダメ
          #if tweet.text.include?("#nowplaying")
          tweet.text.match(/#nowplaying/i) do |f|
            if tweet.text.include?("RT @")
            else
              if play_library.include?("#{tweet.text},#{tweet.id}")
              else
                play_library.push("#{tweet.text},#{tweet.id}")
              end
            end
          end
        end
        #rescue Twitter::Error::TooManyRequests => error
        #  sleep error.rate_limit.reset_in
        #  retry
        #end
    #  end
      count += 1
      client.update("一次処理終わり #{count}")
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
          nowplaydata.user_id = current_user.user_name
          nowplaydata.save
        end
      end
      client.update("sleep.60 #{count}")
      sleep(120)
    end
  end

end
