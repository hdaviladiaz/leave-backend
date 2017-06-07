require 'rest-client'

class PeopleController < ApplicationController
  def path
    'https://jigsaw.thoughtworks.net/api/people'
  end

  def token
    Rails.application.secrets.token_jigsaw
  end

  def index
    response = RestClient.get path, {
      Authorization: token, params: { home_office: 'Quito' }
    }
    render json: response.body
  end

  def show
    id = params[:id]
    response = RestClient.get path, {
      Authorization: token, params: { ids: id }
    }
    render json: response.body
  end
end
