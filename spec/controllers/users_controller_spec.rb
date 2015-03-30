require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :confirmed_user }

  describe "GET #show" do
    it "returns http success" do
      get :show, username: user.username
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #answers" do
    it "returns http success" do
      get :answers, username: user.username
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #questions" do
    it "returns http success" do
      get :questions, username: user.username
      expect(response).to have_http_status(:success)
    end
  end
end
