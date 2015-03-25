require 'rails_helper'

RSpec.describe QuestionsHelper, type: :helper do
  let(:user)     { create :confirmed_user }
  let(:question) { create :question, author: user }
  let(:anonymous_question) { create :anonymous_question, author: user }

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
