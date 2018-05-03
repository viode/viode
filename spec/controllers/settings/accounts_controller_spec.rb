require 'rails_helper'

RSpec.describe Settings::AccountsController, type: :controller do
  let(:user) { create :confirmed_user }

  describe "GET #show" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :show
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "returns http success" do
        get :show
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    context "when not signed in" do
      it "redirects to sign in page" do
        patch :update, params: { user: { email: 'edited@mail.example.net', current_password: '12345678' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "updates email and redirects to account settings page" do
        patch :update, params: { user: { email: 'edited@mail.example.net', current_password: '12345678' } }
        expect(user.reload.unconfirmed_email).to eq('edited@mail.example.net')
        expect(response).to redirect_to(settings_account_path)
      end
    end
  end
end
