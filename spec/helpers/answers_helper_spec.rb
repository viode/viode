require 'rails_helper'

RSpec.describe AnswersHelper, type: :helper do
  let(:user)   { create :confirmed_user }
  let(:answer) { create :answer, author: user }
  let(:anonymous_answer) { create :anonymous_answer, author: user }

  describe "#answer_author" do
    context "when anonymous" do
      it "returns 'Anonymous'" do
        expect(helper.answer_author(anonymous_answer)).to eq('Anonymous')
      end
    end

    context "when not anonymous" do
      it "returns link to author" do
        expected = "<a href=\"/users/#{user.id}\">#{user.username}</a>"
        expect(helper.answer_author(answer)).to eq(expected)
      end
    end
  end
end
