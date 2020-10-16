module Orders 
  class CheckoutForm 
    include ActiveModel::Model
    attr_accessor :user, :course
    validates :user, :course, presence: true
    validate :course_state
    validate :duplicate_course
    
    def initialize(user: , course:)
      @user = user
      @course = course
    end

    def save!
      return false unless valid?

      ActiveRecord::Base.transaction do
        place_order
        checkout_order
        @order.fulfill!

        @order
      end
      # @todo rescue payment failed
    end

    private

    def place_order
      @order = @user.orders.create(course: @course)
    end

    def checkout_order
      @payment = @order.payments.create(amount: @order.amount)
      @payment.charge! 
      # @note: raise error if payment failed,
      #   and turn payment state to failed
      @order.pay!
    end

    def course_state
      return if @course.launched?

      errors.add(:course, "is dlished.")
    end

    def duplicate_course
      return unless @user.available_courses.include?(@course)

      errors.add(:coures, "has been purchased and still available.")
    end
  end
end
