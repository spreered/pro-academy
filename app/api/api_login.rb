class APILogin < Grape::API
  version 'v1', using: :path
  desc 'Login by user\'semail and password, and get access token'
  namespace 'login' do
    params do
      requires :email, type: String, desc: 'email'
      requires :password, type: String, desc: 'password'
    end

    post do
      user = User.find_by(email: params[:email])
      if user.present? && user.valid_password?(params[:password])
        { access_token: user.renew_access_token!, expired_at: user.access_token_expired_at }
      else
        error!('Authentication Failed', 401)
      end
    end
  end
end
