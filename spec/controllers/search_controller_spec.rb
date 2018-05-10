# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    context 'without query params' do
      it 'returns http success' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'with query params' do
      it 'returns http success' do
        get :index, params: { query: 'test' }
        expect(response).to be_successful
      end
    end
  end
end
