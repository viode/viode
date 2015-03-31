require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relations" do
    it { should have_many(:answers).conditions(anonymous: false).
      with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:questions).conditions(anonymous: false).
      with_foreign_key('author_id').dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should_not allow_value('stop!', 'with-slash').
      for(:username).with_message('can contain only letters, numbers and underscore') }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }
    it { should validate_length_of(:fullname).is_at_least(2).is_at_most(90) }
    it { should allow_value('', nil).for(:fullname) }
    it { should validate_length_of(:bio).is_at_most(400) }
  end
end
