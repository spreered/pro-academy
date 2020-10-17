module Entities
  class CategoryEntity < Grape::Entity
    expose :name, as: :category
  end
end
