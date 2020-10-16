FactoryBot.define do
  factory :order do
    user
    course 

    trait :fulfilled do
      after(:create) do |order|
        order.pay!
        order.fulfill!
      end
    end
  end
end
