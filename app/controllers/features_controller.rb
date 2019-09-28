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

  private

  def parse_feature_param
    data = params.dig(:data, :attributes)

    {
      name: data[:name],
      content: data[:content]
    }
  end
end
