class Feature < ApplicationRecord

  def self.create_by_name(name:)
    default_content = "Feature: #{name}"
    Feature.create(name: name, content: default_content)
  end
end