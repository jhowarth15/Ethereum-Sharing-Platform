class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @contract = Contract.find(params[:id])
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
    @contract.item_id = params[:item_id]
    @contract.inquirer_id = current_user.id
    @contract.lender_id = params[:lender_id]
    @contract.deposit = params[:deposit]
    @contract.rental_rate = params[:rental_rate]
    @contract.key = (0...5).map { (65 + rand(26)).chr }.join
    @name = params[:name]
    @min_loan_period = params[:min_loan_period]
    @max_loan_period = params[:max_loan_period]
    @contract.loaned_out = nil
    @contract.returned = nil
    
    
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        @lender = User.find(@contract.lender_id)
        message = 'Inquiry was successfully created. Please email: ' + @lender.email + ' to arrange a meet to exchange code and item.'
        format.html { redirect_to @contract, notice: message }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def initiate
    @contract = Contract.find(params[:id])
    ethAddress = params[:eth_address]
    
    if @contract.returned == nil
      if @contract.key == params[:input]
       @contract.update_attribute(:loaned_out, Time.new)
       @contract.update_attribute(:contract_address, ethAddress)
       initiated = true
      end
      
    @user = User.find(@contract.inquirer_id)
      
      respond_to do |format|
        if initiated
          format.html { redirect_to @contract, notice: 'Contract was successfully initiated.' }
          format.json { render :show, location: @contract }
        else
          format.html { redirect_to @contract, notice: 'Incorrect code. Contract NOT initiated, please try again.' }
          format.json { render :show, location: @contract }
        end
      end
    end
      
      
  end
  
  def returned
    @contract = Contract.find(params[:id])
    @contract.update_attribute(:returned, Time.new)
    
    @user = User.find(@contract.lender_id)
    respond_to do |format|
      format.html { redirect_to @user, notice: '' }
      format.json { render :show, location: @user }
    end
  end
  
  def key_param
     params.require(@contract).permit(:key)
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.fetch(:contract, {})
      params.require(:contract).permit(:id, :created_at, :item_id, :lender_id, :inquirer_id, :key, :loaned_out, :returned, :deposit, :rental_rate, :updated_at, :contract_address)
    end
end
