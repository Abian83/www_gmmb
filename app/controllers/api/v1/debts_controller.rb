class Api::V1::DebtsController < Api::ApplicationController
  before_action :set_debt, only: [:update]
  before_action :get_user

  def index
    @debts = Debt.where(user_id: @user.id )
    render json: @debts
  end

  #Debt:1 user_id:1 contact_id:1 type:'debo|me deben' quantity:5 description:'Bocadillo que me compré' 
  #state:sincronized|pending created_by:web|mobile
  
  # POST /api/v1/debts
  def create
    #TODO: Refactor 
    @debt                  = Debt.new(debt_params)
    @debt.status_pending!
    @debt.type             = Debt.types[params[:type]]
    @debt.user_id          = @user.id
    @debt.created_by_api!

    if @debt.save
      render json: @debt
    else
      render json: @debt.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/debts/1
  #It is only allowed to update :quantity and :description.
  def update
      if @debt.update(params.permit(:quantity, :description))
        render json: @debt 
      else
				render json: @debt.errors, status: :unprocessable_entity
      end
  end

  private

  	def get_user
  		@user = User.find_by(api_token: session[:token])
  	end

    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
    	params.permit(:contact_id, :type, :quantity, :description)
    end


end
