class Payment < ApplicationRecord
  belongs_to :order
  include AASM

  enum state: {pending: 0, success: 1, failed: 2}
  aasm column: :state, enum: true do
    state :pending, initial: true
    state :success, :failed

    event :succeed do
      transitions from: :pending, to: :success
    end
    event :fail do
      transitions from: :pending, to: :failed
    end
  end

  monetize :amount_cents
end
