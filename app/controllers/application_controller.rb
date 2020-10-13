class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def after_sign_in_path_for(user)
    if user.admin?
      admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end

  private

  def record_not_found
    render 'error/not_found', status: 404
  end
end
