require 'rails_helper'

describe Orders::CheckoutForm do
  let(:user) { create :user }
  let(:course) { create :course }
  let(:form) { described_class.new(user: user, course: course) }
  
  describe '#valid?' do
    subject { form.valid? }
    it { is_expected.to be(true) }
    
    context 'when course is delisted' do
      before { course.delisted! }

      it { is_expected.to be(false) }
    end
    context 'when course is duplicated' do
      before { create(:order, :fulfilled, user: user, course: course) }

      it { is_expected.to be(false) }
      it 'has error message' do
        form.valid?
        expect(form.errors.full_messages).to include("Coures has been purchased and still available.")
      end
    end

  end

  describe '#save!' do
    subject { form.save! }
    it { is_expected.to be_truthy }
    it { is_expected.to be_an Order }
    
    it 'create an order' do
      expect{ subject }.to change{ user.orders.count }.from(0).to(1)
    end

    it { is_expected.to be_fulfilled }
  end
end
