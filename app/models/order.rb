class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :payments
  has_one :latest_success_payment, -> { success.order(charged_at: :desc) }, class_name: 'Payment'
  before_validation :set_amount, on: :create
  enum state: {been_placed: 0, paid: 1, fulfilled: 2, cancelled: 3}

  scope :course_available, -> { fulfilled.where('end_at > ?', DateTime.now) }

  include AASM
  aasm column: :state, enum: true do
    state :been_placed, initial: true
    state :paid, :fulfilled, :cancelled

    event :pay do
      before { set_paid_off_time }
      transitions from: :been_placed, to: :paid
    end
    event :fulfill do
      before do
        set_avaliable_time
      end
      transitions from: :paid, to: :fulfilled
    end
    event :cancel do
      transitions from: [:paid, :fulfilled], to: :cancelled
    end
  end

  monetize :amount_cents

  def course_available?
    return false unless fulfilled?

    end_at >= DateTime.now
  end

  private

  def set_amount
    return if course.blank?
    
    self.amount = course.price
  end

  def set_avaliable_time
    update(end_at: course.duration.days.after)
  end

  def set_paid_off_time
    update(paid_at: DateTime.now)
  end

end
