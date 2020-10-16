module Orders 
  class CheckoutForm 
    include ActiveModel::Model
    attr_accessor :user, :course_id, :order
    validates :user, :course_id, presence: true
    validate :course_presence
    validate :course_state
    validate :duplicate_course
    
    def initialize(user: , course_id:)
      @user = user
      @course_id = course_id
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

    def course
      @course ||= Course.find_by(id: @course_id)
    end

    def place_order
      @order = @user.orders.create(course: course)
    end

    def checkout_order
      @payment = @order.payments.create(amount: @order.amount)
      @payment.charge! 
      # @note: raise error if payment failed,
      #   and turn payment state to failed
      @order.pay!
    end

    def course_state
      return if course.nil?
      return if course.launched?

      errors.add(:course, "is dlished.")
    end

    def duplicate_course
      return if course.nil?
      return unless @user.available_courses.include?(course)

      errors.add(:coures, "has been purchased and still available.")
    end

    def course_presence
      return if course.present?

      errors.add(:coures, "can't be found.")
    end
  end
end
