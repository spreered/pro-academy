require 'rails_helper'

describe Order do
  let(:user) { create :user }
  let(:course) { create :course }
  let(:order) { create(:order, user: user, course: course) }

  describe '.with_available_course' do
    let(:order) { create(:order, :fulfilled) }
    before do 
      order
      create(:order)
    end
    subject { Order.course_available }
    
    it { expect(subject.count).to be(1) }
    it { expect(subject).to include(order) }

  end
  
  describe '#fulfill!' do
    subject { order }
    before do
      order.pay!
      order.fulfill!
    end

    it { is_expected.to be_fulfilled }
    it { is_expected.to be_course_available }
    it { expect(subject.end_at).to be_present }
  end
  
end
