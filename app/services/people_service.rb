require 'rest-client'

class PeopleService
  def get_all
    rest_client.get(params: { home_office: HOME_OFFICE }).body
  end

  def get_all_except_me(user_name)
    people = JSON.parse(get_all)
    people.select {|person| person['loginName'] != user_name}
  end

  def get_by_username(user_name)
    rest_client[user_name].get.body
  end

  private

  def rest_client
    RestClient::Resource.new(JIGSAW_PEOPLE_URL, headers: {
       Authorization: Rails.application.secrets.token_jigsaw
   })
  end
end
