require 'rails_helper'

RSpec.describe LeaveRequest, type: :model do

  subject { described_class.new(
    start_date: Faker::Date.forward(10),
    end_date: Faker::Date.forward(10),
    return_date: Faker::Date.forward(10),
    employee_id: Faker::Number.between(1, 10)
  )}

  it "is valid instance of leave request" do
    expect(subject).to be_valid
  end

  it "is not valid leave request without start date" do
    subject.start_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid leave request without end date" do
    subject.end_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid leave request without return date" do
    subject.return_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid leave request without employee id" do
    subject.employee_id = nil
    expect(subject).to_not be_valid
  end

end
