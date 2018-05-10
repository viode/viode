# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  let(:user) { create :confirmed_user }

  describe 'GET #show' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in with user role' do
      before { sign_in user }

      it 'returns not found' do
        get :show
        expect(response.status).to eq(404)
      end
    end

    context 'when signed in with admin role' do
      before do
        sign_in user
        user.admin!
      end

      it 'returns http success' do
        get :show
        expect(response).to be_successful
      end
    end
  end
end
