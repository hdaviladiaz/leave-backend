require 'rails_helper'
require 'csv'

describe InitialDataManager do

  before(:each) do
    @initial_data_manager = InitialDataManager. new
  end

  describe '#manage' do
    it 'should return a matrix with data when a request is done' do
      initial_data_matrix = @initial_data_manager.getInitialData()
      expect(initial_data_matrix).not_to be(nil)
    end
  end
end
