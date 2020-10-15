require 'rails_helper'

describe APILogin do
  let(:user) { create :user }
  let(:email) { user.email }
  let(:password) { '123456' }
  let(:params) { {email: email, password: password} }

  describe 'post api/v1/login' do
    before do
      post( '/api/v1/login', params: params )
    end
    context 'success' do
      it do
        expect(JSON.parse( response.body )['access_token']).to be_present 
      end
    end

    context 'when with wrong login params' do
      context 'with wrong email' do
        let(:email) { 'error@mail.com' }

        it { expect(response.status).to eq(401) }
      end
      context 'with wrong password' do
        let(:password) { '6666666' }

        it { expect(response.status).to eq(401) }
      end
    end
  end
end
