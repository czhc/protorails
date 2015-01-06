require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET edit" do
    it "assigns the requested user as @user" do
      allow(controller).to receive(:current_user).and_return(user)
      get :edit
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    let (:valid_attributes) { FactoryGirl.attributes_for(:user) }
    let (:invalid_attributes) { FactoryGirl.attributes_for(:user).merge({login: nil}) }
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to root" do
        post :create, {:user => valid_attributes}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        expect {
          post :create, {:user => invalid_attributes}
        }.to change(User, :count).by(0)
      end

      it "assign session email" do
        post :create, {:user => invalid_attributes}
        expect(request.session[:user_email]).to eq(invalid_attributes[:email])
      end

      it "assign session action" do
        post :create, {:user => invalid_attributes}
        expect(request.session[:user_action]).to eq(:signup)
      end

      it "redirects to root" do
        post :create, {:user => invalid_attributes}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested user" do
  #       user = User.create! valid_attributes
  #       put :update, {:id => user.to_param, :user => new_attributes}
  #       user.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested user as @user" do
  #       user = User.create! valid_attributes
  #       put :update, {:id => user.to_param, :user => valid_attributes}
  #       expect(assigns(:user)).to eq(user)
  #     end

  #     it "redirects to the user" do
  #       user = User.create! valid_attributes
  #       put :update, {:id => user.to_param, :user => valid_attributes}
  #       expect(response).to redirect_to(user)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the user as @user" do
  #       user = User.create! valid_attributes
  #       put :update, {:id => user.to_param, :user => invalid_attributes}
  #       expect(assigns(:user)).to eq(user)
  #     end

  #     it "re-renders the 'edit' template" do
  #       user = User.create! valid_attributes
  #       put :update, {:id => user.to_param, :user => invalid_attributes}
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested user" do
  #     user = User.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => user.to_param}
  #     }.to change(User, :count).by(-1)
  #   end

  #   it "redirects to the users list" do
  #     user = User.create! valid_attributes
  #     delete :destroy, {:id => user.to_param}
  #     expect(response).to redirect_to(users_url)
  #   end
  # end
end
