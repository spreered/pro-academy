FactoryBot.define do
  factory :user do
    email { 'user@example.com' }
    password { '123456' }
    access_token_expired_at { nil }
    initialize_with { User.find_or_create_by(email: email)}

    trait :with_valid_access_token do
      after(:create) do |user|
        user.update(access_token_expired_at: 7.days.after)
      end
    end
  end

  factory :admin ,class: 'User' do
    email { 'admin@example.com' }
    password { '123456' }
    role { :admin }
    access_token_expired_at { nil }
  end
end
