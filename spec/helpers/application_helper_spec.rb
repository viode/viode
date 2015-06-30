require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#time_tag_for" do
    it "displays relative time for object" do
      allow(Time).to receive(:now) { Time.new(2013, 5, 22) }
      object = Answer.new(created_at: Date.new(2013, 5, 23))
      expected = "<time datetime=\"2013-05-23T00:00:00Z\" class=\"js-timeago\" title=\"May 23, 2013 00:00\">May 23, 2013 00:00</time>"
      expect(helper.time_tag_for(object)).to eq(expected)
    end
  end
end
