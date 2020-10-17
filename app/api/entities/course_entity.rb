module Entities
  class CourseEntity < Base 
   expose :title
   expose :category, merge: true, using: ::Entities::CategoryEntity
   expose :description
   expose :slug
  end
end
