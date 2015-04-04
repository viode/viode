FactoryGirl.define do
  factory :subscription do
    subscriber
  end

  factory :category_subscription, parent: :subscription do
    association :subscribable, factory: :category
  end
end
