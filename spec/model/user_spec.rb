require 'rails_helper'

RSpec.describe User do
  let(:user){ create :user }

  describe '#access_token_expired?' do
    subject { user.access_token_expired? }

    it { is_expected.to be true }
    context 'when not expired' do
      before { user.update(access_token_expired_at: DateTime.now + 1.day) }
      it { is_expected.to be false }
    end
  end

  describe '#renew_access_token!' do
    subject { user.renew_access_token! }

    it 'change access_token' do
      old_token = user.access_token
      subject
      expect(user.reload.access_token).not_to eq old_token
    end
    it 'extend access_token_expired_at' do
      subject
      expect(user.access_token_expired?).to be false 
    end
  end

  describe '#available_courses' do
    let(:course_1) { create(:course, title: 'Course 1', duration: 1) }
    let(:course_2) { create(:course, title: 'Course 2', duration: 7) }
    subject { user.available_courses }
    before do
      create(:order, :fulfilled, course: course_1, user: user)
      create(:order, :fulfilled, course: course_2, user: user)
    end

    it { expect(subject.count).to eq 2 }
    it { expect(subject.map{|c| c.title}).to match_array(['Course 1', 'Course 2']) }

    context '1 course expired' do
      before { Timecop.travel(Time.zone.now + 2.days)  }
      after { Timecop.return }

      it { expect(subject.count).to eq 1 }
      it { expect(subject.map{|c| c.title}).to match_array(['Course 2'])}
    end
  end

  describe '.purchased_courses' do
    let(:course_1) { create(:course, title: 'Course 1', duration: 1) }
    let(:course_2) { create(:course, title: 'Course 2', duration: 7) }
    subject { user.purchased_courses }
    before do
      create(:order, :fulfilled, course: course_1, user: user)
      create(:order, :fulfilled, course: course_2, user: user)
    end

    it { expect(subject.count).to eq 2 }
    it { expect(subject.map{|c| c.title}).to match_array(['Course 1', 'Course 2']) }

    context '1 course expired' do
      before { Timecop.travel(Time.zone.now + 2.days)  }
      after { Timecop.return }

      it { expect(subject.count).to eq 2 }
      it { expect(subject.map{|c| c.title}).to match_array(['Course 1', 'Course 2'])}
    end
  end
end

