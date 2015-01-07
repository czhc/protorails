require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  describe "associations" do
    subject { FactoryGirl.create(:subscriber) }
    it { should belong_to(:user) }
  end

  describe "callbacks" do
    let(:user){ FactoryGirl.create(:user) }
    let(:subscriber){ user.subscriber }
    it '#should create activation token' do
      expect(subscriber.activation_code).to_not be_nil
    end
  end
end
