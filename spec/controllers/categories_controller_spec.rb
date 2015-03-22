require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create :category }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: category.id
      expect(response).to be_success
    end
  end
end
