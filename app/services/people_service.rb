require 'rest-client'

class PeopleService
  def get_all
    return rest_client.get(params: {home_office: HOME_OFFICE}).body
  end

  def get_by_id(id)
    return rest_client.get(params: {ids: id}).body
  end

  private
  def rest_client
    return RestClient::Resource.new(JIGSAW_PEOPLE_URL, headers: {
      Authorization: Rails.application.secrets.token_jigsaw
    })
  end
end
