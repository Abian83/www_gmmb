class DebtsController < ApplicationController
  before_action :set_debt, only: [:show, :edit, :update, :destroy]

  # GET /debts
  # GET /debts.json
  def index
    @title = "All debts" 
    if params[:type] == Debt.types[:my_debt].to_s
      @title = "My debts"
      @debts = Debt.type_my_debts.where(:user => current_user.id).includes(:contact).limit(50)
    elsif params[:type] == Debt.types[:my_debtor].to_s
      @title = "My debtors"
      @debts = Debt.type_my_debtors.where(:user => current_user.id).includes(:contact).limit(50)
    else
      @debts = Debt.all.includes(:contact).limit(50)
    end
    @total = @debts.count
    @total_price = @debts.sum(:quantity)
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
    @contacts = Contact.all.limit(10).map{|x| { label:  x.name, id:  x.id} }.to_json
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  # POST /debts.json
  def create
    binding.pry
    @debt = Debt.new(debt_params)
    @debt.status_pending!
    @debt.type             = Debt.types[params[:debt][:type_cd].to_i]
    @debt.user_id          = current_user.id
    @debt.created_by_web!
    respond_to do |format|
      if @debt.save
        format.html { redirect_to @debt, notice: 'Debt was successfully created.' }
        format.json { render :show, status: :created, location: @debt }
      else
        flash[:error] =  @debt.errors.messages
        format.html { render :new }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    binding.pry
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      respond_to do |format|
        format.html { params.require(:debt).permit(:contact_id, :type_cd, :quantity, :description) }
        format.json { params.permit(:contact_id, :type_cd, :quantity, :description) }
      end
    end
end
