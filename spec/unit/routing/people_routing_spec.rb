require 'rails_helper'

RSpec.describe PeopleController, type: :routing do
  describe 'routing' do
    specify { expect(get: '/people').to route_to('people#index') }
    specify { expect(get: '/people/me').to route_to('people#show') }
  end
end
