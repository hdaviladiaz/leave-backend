require 'rails_helper'
require 'json'

describe LeaveService , type: :service do
  describe '#new' do
    let(:hireDate) { Faker::Date.backward(50) }
    let(:validRequest) do
      {
        result: {
          employeeId:"15576",
          hireDate:hireDate,
          startDate:hireDate.next_day(60),
          endDate:hireDate.next_day(65)
        }
      }
    end

    let(:startDateIsGreaterThanEndDate) do
      {
        result: {
          employeeId:"15576",
          hireDate:hireDate,
          startDate:hireDate.next_day(70),
          endDate:hireDate.next_day(60)
        }
      }
    end

    let(:startDateIsSmallerThanToday) do
      {
        result: {
          employeeId:"15576",
          hireDate:hireDate,
          startDate:Date.yesterday,
          endDate:Date.tomorrow
        }
      }
    end

    let(:startDateIsSmallerThanHiredDate) do
      {
        result: {
          employeeId:"15576",
          hireDate:hireDate.next_day(80),
          startDate:hireDate.next_day(70),
          endDate:hireDate.next_day(75)
        }
      }
    end


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

    it 'should not create leave-request when user choose a startDate smaller than today' do
      leave_service = LeaveService. new
      leave_request = JSON.parse(startDateIsSmallerThanToday.to_json())
      expect(leave_service.createLeaveRequest(leave_request)).to eq('Error! The start date is smaller than today')
    end

    it 'should not create leave-request when user choose a startDate smaller than hired date' do
      leave_service = LeaveService. new
      leave_request = JSON.parse(startDateIsSmallerThanHiredDate.to_json())
      expect(leave_service.createLeaveRequest(leave_request)).to eq('Error! The start date is smaller than hired date')
    end
  end
end
