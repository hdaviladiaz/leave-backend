require 'rails_helper'

describe ManagerInitialDataController, type: :controller do

  describe '#load_initial_data' do

      it 'should return a not nil array when get the initial data from csv_file' do
        manager_initial_data_controller = ManagerInitialDataController. new
        total_leaves = manager_initial_data_controller.get_total_leaves()
        expect(total_leaves).not_to be(nil)
      end

      it 'should return an array with initial data from csv_file' do
        manager_initial_data_controller = ManagerInitialDataController. new
        total_leaves = manager_initial_data_controller.get_total_leaves()
        expect(total_leaves.length).not_to be(0)
      end

  end

end
