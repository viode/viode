# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :confirmed_user }

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { username: user.username }
      expect(response).to be_successful
    end
  end

  describe 'GET #answers' do
    it 'returns http success' do
      get :answers, params: { username: user.username }
      expect(response).to be_successful
    end
  end

  describe 'GET #questions' do
    it 'returns http success' do
      get :questions, params: { username: user.username }
      expect(response).to be_successful
    end
  end
end
