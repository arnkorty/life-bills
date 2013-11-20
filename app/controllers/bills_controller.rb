class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
     Rails.logger.warn params[:search]
    if params[:search].blank?
      @bills = Bill.all.includes(:person,:account,:item)
    else
      @bills = Bill.all
      params[:search].each do |s|
        # logger.info params[:search]
        # p '*' * 200
        # p params[:search]
        s.each do |key,value|
          if value.is_a?(Hash)
            @bills = @bills.where(key.to_s.sub(/_i\d{0,3}$/,'').to_sym.send(value[:target] || :gte) => value[:value])
          else
            @bills = @bills.where(key.to_s.sub(/_i\d{0,3}$/,'') => value)
          end
        end
      end
    end    
    @bill    = current_user.bills.new
    @person  = Person.new
    @account = Account.new
    @item    = Item.new
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
    render 'edit',layout: false
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = current_user.bills.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:bill_type_id, :item_id, :account_id, :money, :person_id, :bill_time, :remark)
    end
end
