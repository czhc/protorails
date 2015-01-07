require 'rails_helper'

RSpec.describe UserSessionsController, :type => :controller do
  let (:user) { FactoryGirl.create(:user, password: "validPASS123") }
  describe "GET new" do
    it "assigns session params" do
      get :new
      expect(request.session[:user_action]).to eq(:signin)
    end

    it "redirects to root" do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST create" do
    let (:valid_attributes) { { username: user.login, password: "validPASS123"}}

    describe "with valid user credentials" do
      it "signs in user" do
        post :create, { user_session: valid_attributes }
        expect(request.session[:user_id]).to eq(user.id)
      end

      it "sanitizes sign in params" do
        post :create, { user_session: valid_attributes }
        expect(request.session[:user_action]).to be_nil
      end

      it "redirects to root" do
        post :create, { user_session: valid_attributes.merge({username: nil}) }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid user credentials" do
      it "with nil credentials" do
        post :create, { user_session: valid_attributes.merge({username: nil}) }
        expect(request.session[:user_id]).to be_nil
      end

      it "with wrong credentials" do
        post :create, { user_session: valid_attributes.merge({username: "nologin"}) }
        expect(request.session[:user_id]).to be_nil
      end

      it "redirects to root" do
        post :create, { user_session: valid_attributes.merge({username: nil}) }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE destroy" do
    describe "with current user" do
      before { allow(controller).to receive(:current_user).and_return(user) }
      it "signs out user" do
        delete :destroy
        expect(request.session[:user_id]).to be_nil
      end

      it "redirects to root" do
        delete :destroy
        expect(response).to redirect_to root_path
      end
    end
  end
end
