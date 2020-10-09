class Admin::BaseController < ApplicationController 
  layout "admin"
  before_action :authenticate_admin!

  def authenticate_admin!
    unless user_signed_in? && current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
