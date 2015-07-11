class Api::V1::UsersController < Api::ApplicationController
  #before_action :set_debt, only: [:show, :edit, :update, :destroy]
  #before_action :get_user

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    #Save it in downcase always.
    @user.email.downcase! if @user.email
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      respond_to do |format|
        format.json { params.permit(:name, :email, :password, :phone) }
      end
    end


end
