require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relations" do
    it { should have_many(:questions).dependent(:destroy) }
  end
end
