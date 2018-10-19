# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)     { Fabricate :confirmed_user }
  let(:question) { Fabricate :question, author: user }
  let(:answer)   { Fabricate :answer, question: question, author: user }

  describe 'GET #new' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :new, params: { question_id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      it 'returns http success' do
        sign_in user

        get :new, params: { question_id: question.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :create, params: { question_id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      it 'creates answer and redirects to question page' do
        sign_in user

        expect do
          post :create, params: { question_id: question.id, answer: Fabricate.attributes_for(:answer) }
        end.to change(Answer, :count).by(1)
        expect(response).to redirect_to(question)
      end
    end
  end

  describe 'POST #upvote' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :upvote, params: { id: answer.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'upvotes answer and redirects to answer question' do
        expect do
          post :upvote, params: { id: answer.id }
        end.to change { answer.reputation_for(:votes) }.by(1)
        expect(response).to redirect_to(answer.question)
      end

      it 'returns http success for remote request' do
        post :upvote, params: { id: answer.id }, xhr: true
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #downvote' do
    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :downvote, params: { id: answer.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      before { sign_in user }

      it 'downvotes answer and redirects to answer question' do
        expect do
          post :downvote, params: { id: answer.id }
        end.to change { answer.reputation_for(:votes) }.by(-1)
        expect(response).to redirect_to(answer.question)
      end

      it 'returns http success for remote request' do
        post :downvote, params: { id: answer.id }, xhr: true
        expect(response).to be_successful
      end
    end
  end
end
