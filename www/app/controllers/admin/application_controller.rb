class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_filter :verify_admin
  layout 'admin'
  
  def verify_admin
    redirect_to root_url unless current_user.has_role?(:admin)
  end
end
