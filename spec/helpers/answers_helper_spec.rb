require 'rails_helper'

RSpec.describe AnswersHelper, type: :helper do
  let(:user)   { create :confirmed_user }
  let(:answer) { create :answer, author: user, id: 777 }
  let(:anonymous_answer) { create :anonymous_answer, author: user }

  describe "#link_to_answer_upvote" do
    context "when not signed in" do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it "returns link to sign in" do
        expect(helper.link_to_answer_upvote(answer)).to eq("<a href=\"/login\"><span class=\"fa fa-arrow-up fa-lg\"></span></a>")
      end
    end

    context "when signed in" do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context "when user not upvoted answer" do
        it "returns link to upvote answer without 'active' class" do
          upvote_link = helper.link_to_answer_upvote(answer)
          expect(upvote_link).to start_with('<a class=" js-answer-upvote-link" data-disable-with=')
          expect(upvote_link).to end_with('<span class="fa fa-arrow-up fa-lg"></span></a>')
        end
      end

      context "when user upvoted answer" do
        it "returns link to upvote answer with 'active' class" do
          answer.upvote_by user
          upvote_link = helper.link_to_answer_upvote(answer)
          expect(upvote_link).to start_with('<a class="active js-answer-upvote-link" data-disable-with=')
          expect(upvote_link).to end_with('<span class="fa fa-arrow-up fa-lg"></span></a>')
        end
      end
    end
  end

  describe "#link_to_answer_downvote" do
    context "when not signed in" do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it "returns link to sign in" do
        expect(helper.link_to_answer_downvote(answer)).to eq("<a href=\"/login\"><span class=\"fa fa-arrow-down fa-lg\"></span></a>")
      end
    end

    context "when signed in" do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context "when user not downvoted answer" do
        it "returns link to downvote answer without 'active' class" do
          downvote_link = helper.link_to_answer_downvote(answer)
          expect(downvote_link).to start_with('<a class=" js-answer-downvote-link" data-disable-with=')
          expect(downvote_link).to end_with('<span class="fa fa-arrow-down fa-lg"></span></a>')
        end
      end

      context "when user downvoted answer" do
        it "returns link to downvote answer with 'active' class" do
          answer.downvote_by user
          downvote_link = helper.link_to_answer_downvote(answer)
          expect(downvote_link).to start_with('<a class="active js-answer-downvote-link" data-disable-with=')
          expect(downvote_link).to end_with('<span class="fa fa-arrow-down fa-lg"></span></a>')
        end
      end
    end
  end

  describe "#answer_author" do
    context "when anonymous" do
      it "returns 'Anonymous'" do
        expect(helper.answer_author(anonymous_answer)).to eq('Anonymous')
      end
    end

    context "when not anonymous" do
      it "returns link to author" do
        expected = "<a href=\"/users/#{user.username}\">#{user.username}</a>"
        expect(helper.answer_author(answer)).to eq(expected)
      end
    end
  end
end
