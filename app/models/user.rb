class User < ApplicationRecord
    def self.find_or_create_from_auth(auth)
        provider = auth[:provider]
        uid = auth[:uid]
        user_name = auth[:info][:name]
        image_url = auth[:info][:image]

        self.find_or_create_by(provider: provider, uid: uid) do |user|
            user.user_name = user_name
            user.image_url = image_url
            user.screen_name = user_screen_name
        end
    end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
    end
  end
end
