class Api::V1::UsersController < Api::ApplicationController
  before_action :set_user, only: [:update]
  #before_action :get_user

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  #It is only allowed to update :quantity and :description.
  def update
      if @user.update(user_params)
        render json: @user 
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end


  private
    
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      respond_to do |format|
        format.json { params.permit(:name, :email, :password, :phone) }
      end
    end


end
