require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "relations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:category_id) }
  end
end
