class Feature < ApplicationRecord

  def self.create_by_name(name:)
    default_content = "Feature: #{name}"
    Feature.create(name: name, content: default_content)
  end

  def self.create_by_content(content:)
    feature_prototype = content.split("\n").first
    feature_prototype.slice!("Feature: ")

    Feature.create(name: feature_prototype, content: content)
  end
end