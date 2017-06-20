require 'rails_helper'
require 'json'

describe LeaveService , type: :service do
  describe '#new' do
    let(:validRequest) do
      {
        result: {
          employeeId:"15576",
          hireDate:"2013-08-05",
          startDate:"25/06/2017",
          endDate:"30/06/2017"
        }
      }
    end

    let(:startDateIsGreaterThanEndDate) do
      {
        result: {
          employeeId:"15576",
          hireDate:"2013-08-05",
          startDate:"20/06/2017",
          endDate:"15/06/2017"
        }
      }
    end

    let(:startDateIsSmallerThanToday) do
      {
        result: {
          employeeId:"15576",
          hireDate:"2013-08-05",
          startDate:"15/06/2017",
          endDate:"20/06/2017"
        }
      }
    end

    let(:startDate) { Faker::Date.forward(50) }
    let(:endDate) { Faker::Date.forward(50) }

    it 'sould create leave-request when user choose a valid range od days' do
      leave_service = LeaveService. new
      leave_request = JSON.parse(validRequest.to_json())
      expect(leave_service.createLeaveRequest(leave_request)).to eq('Success!')
    end

    it 'should not create leave-request when user choose an endDate grather than startDate' do
      leave_service = LeaveService. new
      leave_request = JSON.parse(startDateIsGreaterThanEndDate.to_json())
      expect(leave_service.createLeaveRequest(leave_request)).to eq('Error! The start date is greater than end date')
    end

    it 'should not create leace-request when user choose a startDate smaller than today' do
      leave_service = LeaveService. new
      leave_request = JSON.parse(startDateIsSmallerThanToday.to_json())
      expect(leave_service.createLeaveRequest(leave_request)).to eq('Error! The start date is smaller than today')
    end

  end
end
