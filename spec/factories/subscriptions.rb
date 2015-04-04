FactoryGirl.define do
  factory :subscription do
    subscriber
    # association :subscribable, factory: :category
  end
end
