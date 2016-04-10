require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user)     { create :confirmed_user }
  let(:category) { create :category }
  let(:question) { create :question, author: user }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "when id and permalink present" do
      it "returns http success" do
        get :show, id: question.id, permalink: question.permalink
        expect(response).to be_success
      end
    end

    context "when permalink not present" do
      it "redirects with status 301" do
        get :show, id: question.id
        expect(response).to redirect_to(question)
        expect(response.status).to eq(301)
      end
    end

    context "when permalink not valid" do
      it "redirects with status 301" do
        get :show, id: question.id, permalink: 'test'
        expect(response).to redirect_to(question)
        expect(response.status).to eq(301)
      end
    end

    it "updates views count" do
      views_before = question.views

      get :show, id: question.id
      expect(question.reload.views).to eq(views_before + 1)
    end
  end

  describe "GET #new" do
    context "when not signed in" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "returns http success" do
        get :new
        expect(response).to be_success
      end
    end
  end

  describe "POST #create" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      it "creates question and redirects to question page" do
        sign_in user

        expect {
          post :create, question: attributes_for(:question, category_id: category.id)
        }.to change(Question, :count).by(1)
        expect(response).to redirect_to(Question.last)
      end

      context "when there is an intended respondent" do 
        include ActiveJob::TestHelper
        let!(:bob) { create :confirmed_user, username: "bob"}

        it "assigns an intended respondent" do 
          sign_in user

          post :create, question: attributes_for(:question, category_id: category.id, intended_respondent: bob.id)
          expect(Question.last.intended_respondent).to eql(bob.id)
        end

        it "enqueues the email to be sent later" do 
          sign_in user
          
          expect {
            post :create, question: attributes_for(:question, category_id: category.id, intended_respondent: bob.id)
          }.to change{enqueued_jobs.size}.by(1)
        end
      end

      context "when there isn't an intended respondent" do 
        include ActiveJob::TestHelper

        it "does not enqueue an email to be sent later" do 
          sign_in user
          
          expect {
            post :create, question: attributes_for(:question, category_id: category.id)
          }. to change{enqueued_jobs.size}.by(0)
        end
      end
    end
  end

  describe "POST #upvote" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :upvote, id: question.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "upvotes question and redirects to question" do
        expect {
          post :upvote, id: question.id
        }.to change { question.reputation_for(:votes) }.by(1)
        expect(response).to redirect_to(question)
      end

      it "returns http success for remote request" do
        xhr :post, :upvote, id: question.id
        expect(response).to be_success
      end
    end
  end

  describe "POST #downvote" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :downvote, id: question.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "downvotes question and redirects to question" do
        expect {
          post :downvote, id: question.id
        }.to change { question.reputation_for(:votes) }.by(-1)
        expect(response).to redirect_to(question)
      end

      it "returns http success for remote request" do
        xhr :post, :downvote, id: question.id
        expect(response).to be_success
      end
    end
  end

  describe "POST #star" do
    context "when not signed in" do
      it "redirects to sign in page" do
        post :star, id: question.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "stars question and redirects to question" do
        expect {
          post :star, id: question.id
        }.to change { question.reputation_for(:stars) }.by(1)
        expect(response).to redirect_to(question)
      end

      it "returns http success for remote request" do
        xhr :post, :star, id: question.id
        expect(response).to be_success
      end
    end
  end
end
