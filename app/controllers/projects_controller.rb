class ProjectsController < ApplicationController
  include AuthentificationConcern

  def index
    render json: {}
  end
end
