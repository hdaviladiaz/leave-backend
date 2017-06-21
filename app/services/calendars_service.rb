require 'rest-client'

class CalendarsService
  def get_all
    rest_client[HOME_OFFICE][Time.zone.now.year].get.body
  end

  private

  def rest_client
    RestClient::Resource.new(JIGSAW_CALENDAR_URL, headers: {
                               Authorization: Rails.application.secrets.token_jigsaw
                             })
  end
end
