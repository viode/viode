require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user)       { create :confirmed_user }
  let(:other_user) { create :confirmed_user }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :edit, id: user.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      context "when current user" do
        it "returns http success" do
          get :edit, id: user.id
          expect(response).to be_success
        end
      end

      context "when other user" do
        it "redirects to root path" do
          get :edit, id: other_user.id
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "POST #update" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :update, id: user.id, user: attributes_for(:user, email: 'edited@mail.example.net')
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      context "when current user" do
        it "updates user settings and redirects to user page" do
          post :update, id: user.id, user: attributes_for(:user, email: 'edited@mail.example.net')
          expect(user.reload.unconfirmed_email).to eq('edited@mail.example.net')
          expect(response).to redirect_to(user)
        end
      end

      context "when other user" do
        it "does not update user settings and redirects to root path" do
          post :update, id: other_user.id, user: attributes_for(:user, email: 'edited@mail.example.net')
          expect(other_user.reload.unconfirmed_email).to_not eq('edited@mail.example.net')
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
