User.find_or_create_by( email: "admin@pro-academy.com") do |user|
  user.password = "12345678"
  user.role = :admin 
end

Category.find_or_create_by(name: 'Development')
Category.find_or_create_by(name: 'Business')
Category.find_or_create_by(name: 'Finance')
Category.find_or_create_by(name: 'Design')
Category.find_or_create_by(name: 'Marketing')
