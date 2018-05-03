require 'rails_helper'

RSpec.describe Settings::PasswordsController, type: :controller do
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
        patch :update, params: { user: { current_password: '12345678', password: 'new pass', password_confirmation: 'new pass' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "updates password and redirects to password settings page" do
        patch :update, params: { user: { current_password: '12345678', password: 'new pass', password_confirmation: 'new pass' } }
        expect(user.reload.valid_password?('new pass')).to be_truthy
        expect(response).to redirect_to(settings_password_path)
      end
    end
  end
end
