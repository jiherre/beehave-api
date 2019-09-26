module AuthentificationConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  private

  def authenticate_request!
    if valid_token?
      @current_user = User.find(auth_token[:user_id])
    else
      render json: {}, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {}, status: :unauthorized
  end

  def valid_token?
    request.headers['Authorization'].present? && auth_token.present?
  end

  def auth_token
    @auth_token ||= JsonWebTokenService.decode(request.headers['Authorization'].split(' ').last)
  end
end