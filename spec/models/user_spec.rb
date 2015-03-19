require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relations" do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
  end
end
