# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsHelper, type: :helper do
  let(:user)     { create :confirmed_user }
  let(:question) { create :question, author: user, id: 777 }
  let(:anonymous_question) { create :anonymous_question, author: user }

  describe '#link_to_question_star' do
    context 'when not signed in' do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it 'returns empty string' do
        expect(helper.link_to_question_star(question)).to eq('')
      end
    end

    context 'when signed in' do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context 'when user not starred question' do
        it 'returns link to star question' do
          star_link = helper.link_to_question_star(question)
          expect(star_link).to start_with('<a class="star" title="Star this question" data-remote="true"')
          expect(star_link).to end_with('<span class="fa fa-star-o fa-2x"></span></a>')
        end
      end

      context 'when user starred question' do
        it 'returns link to unstar question' do
          question.star_by user
          star_link = helper.link_to_question_star(question)
          expect(star_link).to start_with('<a class="star" title="Unstar this question" data-remote="true"')
          expect(star_link).to end_with('<span class="fa fa-star fa-2x"></span></a>')
        end
      end
    end
  end

  describe '#link_to_question_upvote' do
    context 'when not signed in' do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it 'returns link to sign in' do
        expect(helper.link_to_question_upvote(question)).to eq('<a href="/login"><span class="fa fa-arrow-up fa-lg"></span></a>')
      end
    end

    context 'when signed in' do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context 'when user not upvoted question' do
        it "returns link to upvote question without 'active' class" do
          upvote_link = helper.link_to_question_upvote(question)
          expect(upvote_link).to start_with('<a class=" js-question-upvote-link" data-disable-with=')
          expect(upvote_link).to end_with('<span class="fa fa-arrow-up fa-lg"></span></a>')
        end
      end

      context 'when user upvoted question' do
        it "returns link to upvote question with 'active' class" do
          question.upvote_by user
          upvote_link = helper.link_to_question_upvote(question)
          expect(upvote_link).to start_with('<a class="active js-question-upvote-link" data-disable-with=')
          expect(upvote_link).to end_with('<span class="fa fa-arrow-up fa-lg"></span></a>')
        end
      end
    end
  end

  describe '#link_to_question_downvote' do
    context 'when not signed in' do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it 'returns link to sign in' do
        expect(helper.link_to_question_downvote(question)).to eq('<a href="/login"><span class="fa fa-arrow-down fa-lg"></span></a>')
      end
    end

    context 'when signed in' do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context 'when user not downvoted question' do
        it "returns link to downvote question without 'active' class" do
          downvote_link = helper.link_to_question_downvote(question)
          expect(downvote_link).to start_with('<a class=" js-question-downvote-link" data-disable-with=')
          expect(downvote_link).to end_with('<span class="fa fa-arrow-down fa-lg"></span></a>')
        end
      end

      context 'when user downvoted question' do
        it "returns link to downvote question with 'active' class" do
          question.downvote_by user
          downvote_link = helper.link_to_question_downvote(question)
          expect(downvote_link).to start_with('<a class="active js-question-downvote-link" data-disable-with=')
          expect(downvote_link).to end_with('<span class="fa fa-arrow-down fa-lg"></span></a>')
        end
      end
    end
  end

  describe '#question_author' do
    context 'when anonymous' do
      it "returns 'Anonymous'" do
        expect(helper.question_author(anonymous_question)).to eq('Anonymous')
      end
    end

    context 'when not anonymous' do
      it 'returns link to author' do
        expected = "<a href=\"/users/#{user.username}\">#{user.username}</a>"
        expect(helper.question_author(question)).to eq(expected)
      end
    end
  end
end
