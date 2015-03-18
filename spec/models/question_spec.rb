require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "relations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end
end
