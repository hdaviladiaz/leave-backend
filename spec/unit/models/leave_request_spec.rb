require 'rails_helper'

RSpec.describe LeaveRequest, type: :model do
  subject do
    described_class.new(
      start_date: Faker::Date.forward(10),
      end_date: Faker::Date.forward(10),
      return_date: Faker::Date.forward(10),
      employee_id: Faker::Internet.email,
      approver_id: Faker::Internet.email,
      initial_load: Faker::Boolean.boolean
    )
  end

  it 'is valid instance of leave request' do
    expect(subject).to be_valid
  end

  it 'is not valid leave request without start date' do
    subject.start_date = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid leave request without end date' do
    subject.end_date = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid leave request without return date' do
    subject.return_date = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid leave request without employee id' do
    subject.employee_id = nil
    expect(subject).to_not be_valid
  end

  it 'is a valid leave request without flag initial load' do
    subject.initial_load = nil
    expect(subject).to be_valid
  end
end
