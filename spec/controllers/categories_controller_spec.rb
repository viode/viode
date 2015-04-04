require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create :category }
  let(:user)     { create :confirmed_user }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, permalink: category.permalink
      expect(response).to be_success
    end
  end

  describe "POST #subscribe" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :subscribe, permalink: category.permalink
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "subscribes user to category and redirects to category page" do
        expect {
          post :subscribe, permalink: category.permalink
        }.to change(category.subscriptions, :count).by(1)
        expect(response).to redirect_to(category)
      end

      it "returns http success for remote request" do
        xhr :post, :subscribe, permalink: category.permalink
        expect(response).to be_success
      end
    end
  end

  describe "POST #unsubscribe" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :unsubscribe, permalink: category.permalink
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before do
        sign_in user
        user.subscriptions.create subscribable: category
      end

      it "unsubscribes user from category and redirects to category page" do
        expect {
          post :unsubscribe, permalink: category.permalink
        }.to change(category.subscriptions, :count).by(-1)
        expect(response).to redirect_to(category)
      end

      it "returns http success for remote request" do
        xhr :post, :unsubscribe, permalink: category.permalink
        expect(response).to be_success
      end
    end
  end
end
