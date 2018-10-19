# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:user)     { Fabricate :confirmed_user }
  let(:question) { Fabricate :question, author: user }

  describe 'GET #show' do
    it 'returns http success' do
      tag = question.tags.sample
      get :show, params: { name: tag.name }
      expect(response).to be_successful
    end
  end
end
