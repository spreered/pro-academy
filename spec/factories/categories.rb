FactoryBot.define do
  factory :category do
    name {'Some Category'}
    initialize_with { Category.find_or_create_by(name: name)}
  end
end
