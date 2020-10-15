module APIHelper
  module AuthenticationHelper
    def authenticate!
      return if current_user.present?

      error!({ message: "Authentication failed" }, 401)
    end
    
    def sign_in?
      current_user.present?
    end

    def current_user
      @current_user ||= User.verify(access_token)
    end

    def access_token
      @access_token ||= headers['Authorization']
    end
  end
end
