class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :payments
  
  include AASM

  enum state: {been_placed: 0, paid: 1, fulfilled: 2, cancelled: 3}

  aasm column: :state, enum: true do
    state :been_placed, initial: true
    state :paid, :fulfilled, :cancelled

    event :pay do
      transitions from: :been_placed, to: :paid
    end
    event :fulfill do
      transitions from: :paid, to: :fulfilled
    end
    event :cancel do
      transitions from: [:paid, :fulfilled], to: :cancelled
    end
  end
end
