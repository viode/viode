require 'rails_helper'

RSpec.describe QuestionsHelper, type: :helper do
  let(:user)     { create :confirmed_user }
  let(:question) { create :question, author: user, id: 777 }
  let(:anonymous_question) { create :anonymous_question, author: user }

  describe "#link_to_question_upvote" do
    context "when not signed in" do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it "returns link to sign in" do
        expect(helper.link_to_question_upvote(question)).to eq("<a href=\"/login\"><span class=\"fa fa-arrow-up fa-lg\"></span></a>")
      end
    end

    context "when signed in" do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context "when user not upvoted question" do
        it "returns link to upvote question with 'upvote' class" do
          expect(helper.link_to_question_upvote(question)).to eq(
            "<a class=\" js-question-upvote-link\" data-disable-with=\"&lt;span class=&quot;fa fa-spinner fa-pulse fa-lg&quot;&gt;&lt;/span&gt;\" " \
            "data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/questions/777/upvote\"><span class=\"fa fa-arrow-up fa-lg\"></span></a>"
          )
        end
      end

      context "when user upvoted question" do
        it "returns link to upvote question with 'upvoted' class" do
          question.add_evaluation :upvotes, 1, user
          expect(helper.link_to_question_upvote(question)).to eq(
            "<a class=\"active js-question-upvote-link\" data-disable-with=\"&lt;span class=&quot;fa fa-spinner fa-pulse fa-lg&quot;&gt;&lt;/span&gt;\" " \
            "data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/questions/777/upvote\"><span class=\"fa fa-arrow-up fa-lg\"></span></a>"
          )
        end
      end
    end
  end

  describe "#link_to_question_downvote" do
    context "when not signed in" do
      before { expect(helper).to receive(:user_signed_in?).and_return(false) }

      it "returns link to sign in" do
        expect(helper.link_to_question_downvote(question)).to eq("<a href=\"/login\"><span class=\"fa fa-arrow-down fa-lg\"></span></a>")
      end
    end

    context "when signed in" do
      before do
        expect(helper).to receive(:user_signed_in?).and_return(true)
        expect(helper).to receive(:current_user).and_return(user)
      end

      context "when user not downvoted question" do
        it "returns link to downvote question with 'downvote' class" do
          expect(helper.link_to_question_downvote(question)).to eq(
            "<a class=\" js-question-downvote-link\" data-disable-with=\"&lt;span class=&quot;fa fa-spinner fa-pulse fa-lg&quot;&gt;&lt;/span&gt;\" " \
            "data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/questions/777/downvote\"><span class=\"fa fa-arrow-down fa-lg\"></span></a>"
          )
        end
      end

      context "when user downvoted question" do
        it "returns link to downvote question with 'downvoted' class" do
          question.add_evaluation :downvotes, -1, user
          expect(helper.link_to_question_downvote(question)).to eq(
            "<a class=\"active js-question-downvote-link\" data-disable-with=\"&lt;span class=&quot;fa fa-spinner fa-pulse fa-lg&quot;&gt;&lt;/span&gt;\" " \
            "data-remote=\"true\" rel=\"nofollow\" data-method=\"post\" href=\"/questions/777/downvote\"><span class=\"fa fa-arrow-down fa-lg\"></span></a>"
          )
        end
      end
    end
  end

  describe "#question_author" do
    context "when anonymous" do
      it "returns 'Anonymous'" do
        expect(helper.question_author(anonymous_question)).to eq('Anonymous')
      end
    end

    context "when not anonymous" do
      it "returns link to author" do
        expected = "<a href=\"/users/#{user.id}\">#{user.username}</a>"
        expect(helper.question_author(question)).to eq(expected)
      end
    end
  end
end
