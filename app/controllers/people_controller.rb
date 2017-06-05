require 'rest-client'

class PeopleController < ApplicationController
  def path
    'https://jigsaw.thoughtworks.net/api/people'
  end

  def token
    Rails.application.secrets.token_jigsaw
  end

  def index
    begin
      response = RestClient.get path, {
        Authorization: token, params: { home_office: 'Quito' }
      }
      render json: response.body
    rescue RestClient::Unauthorized
      render json: {}, status: :unauthorized
    end
  end

  def show
    id = params[:id]
    response = RestClient.get path, {
      Authorization: token, params: { ids: id }
    }
    render json: response.body
  end
end
