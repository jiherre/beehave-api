class Project
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end
end

class ProjectsController < ApplicationController
  before_action :authenticate_request!

  def index
    p1 = Project.new(id: 1, name: 'Qui')
    p2 = Project.new(id: 2, name: 'Qui')

    render json: ProjectSerializer.new([p1, p2]).serialized_json
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
