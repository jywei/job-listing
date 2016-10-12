class Admin::ContactController < Admin::ApplicationController

  def index
    @contacts = Contact.all
    Contact.update_all(is_read: true)
  end

  def delete_contact
    contact = Contact.find(params[:id]).delete
    respond_to do |format|
      format.json { render json: { contact: contact } }
    end
  end
end
