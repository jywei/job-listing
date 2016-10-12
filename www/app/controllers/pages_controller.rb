class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:which_role]
  before_action :has_role_check, only: [:which_role]

  def index
    @jobs = Job.includes(:company).order(:views_count).reverse
    @companies = Company.joins(:jobs).group('companies.id').order('RAND()').limit(6)
    @articles = Article.all.order("id DESC").limit(3)
    @featured_employers = Company.order('RAND()').limit(30)
  end

  def which_role
  end

  def contact_us
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.json { render json: { contact: @contact } }
      else
        format.json { render json: { error: "", contact: @contact.errors.full_messages } }
      end
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :phone, :email, :message)
    end

    def has_role_check
      if current_user.has_any_role?
        flash[:alert] = "Sorry, you are not authorized to access this area!"
        redirect_to root_url
      end
    end
end
