require 'octokit'

class FeaturesController < ApplicationController
  include AuthentificationConcern

  def create
    feature_data = parse_feature_param
    new_feature = Feature.create_by_name(name: feature_data.dig(:name))

    render json: FeatureSerializer.new(new_feature).serialized_json
  end

  def index
    render json: FeatureSerializer.new(Feature.all).serialized_json
  end

  def show
    feature = Feature.find(params[:id])
    render json: FeatureSerializer.new(feature).serialized_json
  end

  def update
    feature = Feature.find(params[:id])
    new_values = parse_feature_param

    feature.update_attributes(new_values)

    render json: FeatureSerializer.new(feature).serialized_json
  end

  def push_to_git
    feature = Feature.find(params[:id])
    push_feature_to_git feature
    render json: {}, status: :ok
  end

  private

  def parse_feature_param
    data = params.dig(:data, :attributes)

    {
      name: data[:name],
      content: data[:content]
    }
  end

  def push_feature_to_git(feature)
    client = Octokit::Client.new(access_token: @current_user.access_token)
    get_or_create_content(client, feature)

  end

  def get_or_create_content(client, feature)
  repo_path = "jracenet/hps-behat"
  feature_path = forge_feature_path(feature)
    begin
      file = client.contents(repo_path, path: feature_path)
      feature_sha = file[:sha]

      client.update_contents(repo_path,
                  feature_path,
                  "Updating #{feature.name}",
                  feature_sha,
                  feature.content)
    rescue => e
      client.add_content("jracenet/hps-behat",
                    forge_feature_path(feature),
                    "Add feature #{feature.name}",
                    feature.content)
    end
  end

  def forge_feature_path(feature)
    "features/#{feature.name.parameterize}.feature"
  end
end
