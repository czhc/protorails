require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  describe 'GET home' do
    describe "returns a user" do
      let (:user) { FactoryGirl.create(:user)}
      it 'with user in session' do
        allow(controller).to receive(:current_user).and_return(user)
        get :home
        expect(assigns(:user)).to be(user)
      end

      it 'with no user' do
        get :home
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
end
