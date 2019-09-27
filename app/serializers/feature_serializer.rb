class FeatureSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :content
end
