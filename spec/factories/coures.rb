FactoryBot.define do
  factory :course do
    title { 'Sample Course' }
    slug { title.gsub(/\s|_/, '-').downcase }
    duration { 7 }
    description { 'This is Sample Course' }
    status { :launched }
    price { 9527 }
    category

    initialize_with { Course.find_or_create_by(slug: slug)}
  end
end
