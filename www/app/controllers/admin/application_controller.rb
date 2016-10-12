class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_filter :verify_admin
  before_action :get_contact_unread_count
  layout 'admin'
  
  def verify_admin
    redirect_to root_url unless current_user.has_role?(:admin)
  end

  def get_contact_unread_count
    @unread_contact_count = Contact.where(is_read: false).size
  end
end
