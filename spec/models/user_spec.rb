require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  describe "validations" do
    before do
      user
    end

    it { should validate_uniqueness_of(:login) }
    it { should validate_presence_of(:login) }
    it do
      should ensure_length_of(:login).
      is_at_least(3).
      is_at_most(15)
    end
    it do
      should allow_value(user.login).
        for(:login).
        with_message("Only letters, numbers, - and _ are allowed.")
    end

    it do
      should validate_exclusion_of(:login).
        in_array(User::RESERVED_NAMES).
        with_message("Login not available.")
    end
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it do 
      should allow_value(user.email).
        for(:email).
        with_message("Invalid email format.") 
    end

    it { should validate_presence_of(:password) }
    it do 
      should ensure_length_of(:password).
        is_at_least(8).
        is_at_most(22)
    end
    it { should allow_value(user.password).for(:password) }
  end

  describe ".has secure password" do
    it "with valid password" do
      expect(user.authenticate(user.password)).to be_an_instance_of(User)
    end

    it "with invalid password" do
      expect(user.authenticate("bad password")).to be_falsy
    end
  end

  describe '.find_by_login_or_email' do
    it "for valid credentials" do
      expect(User.find_by_login_or_email(user.login)).to be_an_instance_of(User)
    end

    it "for invalid credentials" do
      expect(User.find_by_login_or_email("non existent")).to be_nil
    end
  end
end
