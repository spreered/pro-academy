FactoryBot.define do
  factory :course do
    title { 'Sample Course' }
    slug { title.gsub(/\s|_/, '-').downcase }
    duration { 7 }
    description { 'This is Sample Course' }
    price { 9527 }
    category
  end
end
