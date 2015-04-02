require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    before { Question.reindex }

    context "without query params" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "with query params" do
      it "returns http success" do
        get :index, query: 'test'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
