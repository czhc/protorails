require "rails_helper"

RSpec.describe UsersController, :type => :routing do
  describe "routing" do
    it "routes get /signin to #new" do
      expect(:get => "/signin").to route_to("user_sessions#new")
    end

    it "routes post /signin to #create" do
      expect(:post => "/signin").to route_to("user_sessions#create")
    end

    it "routes /logout to #destroy" do
      expect(:delete => "/logout").to route_to("user_sessions#destroy")
    end

  end
end
