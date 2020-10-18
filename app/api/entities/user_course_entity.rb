module Entities
  class UserCourseEntity < Base 
   expose :title
   expose :category, merge: true, using: ::Entities::CategoryEntity
   expose :description
   expose :slug
   expose :orders do |instance, _options|
     ::Entities::OrderEntity.represent orders, except: [:course]
   end 
   private

   def orders
     user.orders.select{|order| order.course_id == object.id}
   end

   def user
     options[:user]
   end
  end
end
