class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_secure_token :access_token

  enum role: { normal: 0, admin: 1 }


  def renew_access_token!
    regenerate_access_token
    update(access_token_expired_at: DateTime.now + 1.day)

    access_token
  end 

  def access_token_expired?
    return true if access_token_expired_at.nil?

    access_token_expired_at < DateTime.now
  end
end
