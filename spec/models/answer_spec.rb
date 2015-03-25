require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "relations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:question) }
  end

  describe "validations" do
    it { should validate_presence_of(:body) }
  end
end
