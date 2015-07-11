class Api::V1::DebtsController < Api::ApplicationController
  #before_action :set_debt, only: [:show, :edit, :update, :destroy]
  before_action :get_user

  def index
    @debts = Debt.where(from: @user.id ) + Debt.where(to: @user.id )
    render json: @debts
  end

  # POST /api/v1/debts
  def create
    @debt = Debt.new(debt_params)
    if @debt.save
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
    	params.permit(:from, :to, :quantity, :description)
    end


end
