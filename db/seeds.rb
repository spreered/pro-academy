User.create( email: "admin@pro-academy.com") do |user|
  user.password = "12345678"
  user.role = :admin 
end

Category.create(name: 'Development')
Category.create(name: 'Business')
Category.create(name: 'Finance')
Category.create(name: 'Design')
Category.create(name: 'Marketing')

Category.all.each do |category|
  5.times do |i|
    category.courses.create(
      title: "#{category.name} #{i}",
      status: :launched,
      slug: "#{category.name.downcase}-#{i}",
    )
  end
end
