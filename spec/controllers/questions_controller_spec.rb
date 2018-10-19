# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user)     { Fabricate :confirmed_user }
  let(:category) { Fabricate :category }
  let(:question) { Fabricate :question, author: user }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    context 'when id and permalink present' do
      it 'returns http success' do
        get :show, params: { id: question.id, permalink: question.permalink }
        expect(response).to be_successful
      end
    end

    context 'when permalink not present' do
      it 'redirects with status 301' do
        get :show, params: { id: question.id }
        expect(response).to redirect_to(question)
        expect(response.status).to eq(301)
      end
    end

    context 'when permalink not valid' do
      it 'redirects with status 301' do
        get :show, params: { id: question.id, permalink: 'test' }
        expect(response).to redirect_to(question)
        expect(response.status).to eq(301)
      end
    end

    it 'updates views count' do
      views_before = question.views

      get :show, params: { id: question.id }
      expect(question.reload.views).to eq(views_before + 1)
    end
  end

  describe 'GET #new' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      it 'returns http success' do
        sign_in user

        get :new
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      it 'creates question and redirects to question page' do
        sign_in user

        expect do
          post :create, params: { question: Fabricate.attributes_for(:question, category_id: category.id) }
        end.to change(Question, :count).by(1)
        expect(response).to redirect_to(Question.last)
      end
    end
  end

  describe 'POST #upvote' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :upvote, params: { id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'upvotes question and redirects to question' do
        expect do
          post :upvote, params: { id: question.id }
        end.to change { question.reputation_for(:votes) }.by(1)
        expect(response).to redirect_to(question)
      end

      it 'returns http success for remote request' do
        post :upvote, params: { id: question.id }, xhr: true
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #downvote' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :downvote, params: { id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'downvotes question and redirects to question' do
        expect do
          post :downvote, params: { id: question.id }
        end.to change { question.reputation_for(:votes) }.by(-1)
        expect(response).to redirect_to(question)
      end

      it 'returns http success for remote request' do
        post :downvote, params: { id: question.id }, xhr: true
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #star' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :star, params: { id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'stars question and redirects to question' do
        expect do
          post :star, params: { id: question.id }
        end.to change { question.reputation_for(:stars) }.by(1)
        expect(response).to redirect_to(question)
      end

      it 'returns http success for remote request' do
        post :star, params: { id: question.id }, xhr: true
        expect(response).to be_successful
      end
    end
  end
end
