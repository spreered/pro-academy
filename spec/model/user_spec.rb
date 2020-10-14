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
end
