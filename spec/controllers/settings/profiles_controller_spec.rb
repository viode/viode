# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settings::ProfilesController, type: :controller do
  let(:user) { create :confirmed_user }

  describe 'GET #show' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :show
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'returns http success' do
        get :show
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        patch :update, params: { user: { fullname: 'New name' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'updates profile settings and redirects to profile settings page' do
        patch :update, params: { user: { fullname: 'New name' } }
        expect(user.reload.fullname).to eq('New name')
        expect(response).to redirect_to(settings_profile_path)
      end
    end
  end
end
