class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_user)
    admin_root_path
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end
end
