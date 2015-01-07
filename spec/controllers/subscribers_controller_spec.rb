require 'rails_helper'

RSpec.describe SubscribersController, :type => :controller do
  let (:valid_attributes) { FactoryGirl.attributes_for(:subscriber) }
  let (:invalid_attributes) { FactoryGirl.attributes_for(:subscriber).merge({email: nil}) }

  describe "POST create" do
    it "for valid subscribers" do
      expect {
        post :create, {subscriber: valid_attributes, format: 'js'}
      }.to change(Subscriber, :count).by(1)
    end

    it "for invalid subscribers" do
      expect {
        post :create, {subscriber: invalid_attributes, format: 'js'}
      }.to change(Subscriber, :count).by(0)
    end
  end

  describe "GET activate" do
    let(:subscriber){ FactoryGirl.create(:subscriber)}
    it "activates subscribers" do
      subscriber 
      get :activate, {activation_code: subscriber.activation_code }
      expect(response).to render_template("activate")
    end

    it "redirects invalid subscriber" do
      get :activate, {activation_code: SecureRandom.hex(10)}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET unsubscribe" do
    include ApplicationHelper
    let(:activated_subscriber){ FactoryGirl.create(:activated_subscriber)}
    it "for valid subscribers" do
      get :unsubscribe, {auth_token: verifier.generate(activated_subscriber.email)}
      expect(response).to render_template("unsubscribe")
    end

    it "for invalid subscribers" do
      get :unsubscribe, { auth_token: SecureRandom.hex(37) }
      expect(response).to redirect_to(root_path)
    end
  end
end
