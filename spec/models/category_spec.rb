require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "relations" do
    it { should have_many(:questions).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
