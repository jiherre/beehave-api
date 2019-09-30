require 'octokit'

class GitTreeController < ApplicationController
  REPO_URI = "jracenet/hps-behat"
  FEATURE_PATH_PREFIX = "features/beehave"

  include AuthentificationConcern

  def show
    client = Octokit::Client.new(access_token: @current_user.access_token)
    content = client.contents(REPO_URI, path: "#{FEATURE_PATH_PREFIX}")

    render json: format_git_content(content), status: :ok
  end

  private

  def format_git_content(content)
    content.map do |file|
      {
        id: file[:sha],
        name: file[:name],
        download_url: file[:download_url]
      }
    end
  end
end