require 'rest-client'

class CalendarsService
  def get_all
    year = Time.zone.now.year;
    transform_json(call_rest_client(year), call_rest_client(year+1))
  end

  private

  def rest_client
    RestClient::Resource.new(JIGSAW_CALENDAR_URL, headers: {
                               Authorization: Rails.application.secrets.token_jigsaw
                             })
  end

  def call_rest_client(year)
    rest_client[HOME_OFFICE][year].get.body
  end

  def transform_json(json_first, json_second)
    JSON.parse(json_first).concat(JSON.parse(json_second))
  end
end
