class ItemsController < ApplicationController
  before_action :authenticate_user!, :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /items
  # GET /items.json
  # if search parameters are present, use them to narrow the list of the items
  def index
    @items = Item.all
    if params[:search_loc].present? and params[:search]
      @items = Item.search(params[:search]).near(params[:search_loc], 200)
    elsif params[:search_loc].present?
      @items = Item.near(params[:search_loc], 200)
    elsif params[:search]
      @items = Item.search(params[:search])
    else
      @items = Item.all
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    if user_signed_in?
      @item = Item.new
    else
      flash[:danger] = "You should log in before adding an item."
      redirect_to login_path
    end
  end

  # GET /items/1/edit
  def edit
    # if @item.user_id == @current_user.id
    # end
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:id, :name, :category, :model, :age, :location, :min_loan_period, :max_loan_period, :deposit, :rental_rate, :user_id)
    end
end
