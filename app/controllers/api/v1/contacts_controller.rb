class Api::V1::ContactsController < Api::ApplicationController
  before_action :set_contact, only: [:update]
  before_action :get_user

  # GET /api/v1/contacts
  def index
    @contacts = Contact.where(user_id: @user.id)
    render json: @contacts
  end

  # POST /api/v1/contacts
  def create
    @contact = Contact.new(contacts_params)
    @contact.user_id = @user.id
    if @contact.save
      render json: format_response(@contact)
    else
      render json: format_response(@contact), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/contacts/1
  def update
      if @contact.update(contacts_params)
        render json: format_response(@contact)
      else
        render json: format_response(@contact), status: :unprocessable_entity
      end
  end


  private

    def get_user
      @user = User.find_by(api_token: session[:token])
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contacts_params
      params.permit(:name, :email, :phone)
    end


end
