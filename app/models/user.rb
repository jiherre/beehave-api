class User < ApplicationRecord
  def self.from_github(user_info, access_token = nil)
    github_id = user_info.id

    find_or_create_by(github_id: github_id) do |user|
      user.email = user_info.email
      user.name = user_info.name
      user.image_url = user_info.avatar_url
      user.access_token = access_token
    end
  end
end
