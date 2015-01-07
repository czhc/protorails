require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  let(:subscriber) { FactoryGirl.create(:subscriber) }
  describe "instance attributes" do
    subject { FactoryGirl.create(:subscriber) }
    it { should belong_to(:user) }
    it { should define_enum_for(:state) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it do 
      should allow_value(subscriber.email).
        for(:email).
        with_message("Invalid email format.") 
    end
  end

  describe "subscription" do
    let(:activated_subscriber) { FactoryGirl.create(:activated_subscriber) }
    it "defaults to pending" do
      expect(subscriber.state).to eq("pending")
    end

    describe "#activate!" do
      it 'sets attributes' do
        Timecop.freeze
        subscriber.activate!
        expect(subscriber.state).to eq('activated')
        expect(subscriber.activated_at).to eq(Time.now)
        expect(subscriber.activation_code).to be_nil
        expect(subscriber).to be_valid
      end

      after { Timecop.return }
    end

    describe "#unsubscribe!" do
      it 'sets attributes' do
        Timecop.freeze
        activated_subscriber.unsubscribe!
        expect(activated_subscriber.state).to eq('unsubscribed')
        expect(activated_subscriber.unsubscribed_at).to eq(Time.now)
        expect(activated_subscriber).to be_valid
      end
    end
  end

  describe "callbacks" do
    let(:subscriber){ FactoryGirl.create(:subscriber)}
    it '#should create activation token' do
      expect(subscriber.activation_code).to_not be_nil
    end
  end
end
