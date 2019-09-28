class TokensController < ApplicationController
  include HTTParty

  def create
    service = GithubAccessGetterService.new(params)
    user = service.get_or_create_current_user

    render json: payload(user), status: :ok
  end

  private

  def payload(user)
    {
      access_token: JsonWebTokenService.encode(user_id: user.id),
      user: user
    }
  end
end
