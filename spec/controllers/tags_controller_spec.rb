require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:user)     { create :confirmed_user }
  let(:question) { create :question, author: user }

  describe "GET #show" do
    it "returns http success" do
      tag = question.tags.sample
      get :show, params: { name: tag.name}
      expect(response).to be_successful
    end
  end
end
