require 'octokit'

class TokensController < ApplicationController
  include HTTParty

  def create
    token = get_access_token
    user_info = get_current_user_profile(token)
    user = User.from_github(user_info, token)

    render json: payload(user), status: :ok
  end

  private

  def get_current_user_profile(token)
    client = Octokit::Client.new(access_token: token)
    client.user
  end

  def get_access_token
    res = HTTParty.post('https://github.com/login/oauth/access_token',{
      headers: {
        'Accept' => 'application/json'
      },
      body: {
        client_id:  "7f026a219b30b86d64fa",
        client_secret: "615eb56bff46c7d6a6e1b0e5971851c400e24885",
        code: params['code'],
        grant_type: 'authorization_code',
        redirect_uri: "http://localhost:4200/oauth2"
      }
    })

    JSON.parse(res.body)["access_token"]
  end

  def payload(user)
    {
      access_token: JsonWebTokenService.encode(user_id: user.id),
      user: user
    }
  end
end
