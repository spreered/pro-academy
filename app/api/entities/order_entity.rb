module Entities
  class OrderEntity < Base 
    expose :course, using: CourseEntity
    expose :state, as: :order_state
    expose :amount, format_with: :money
    expose :amount_currency
    expose :end_at, format_with: :iso_timestamp
  end
end
