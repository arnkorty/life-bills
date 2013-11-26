class WeixinWeb::BillsController < WeixinWeb::ApplicationController
  # before_action :set_weixin_web_bill, only: [:show, :edit, :update, :destroy]
  # # GET /weixin_web/bills
  # # GET /weixin_web/bills.json 
	
	before_action :request_user?
  before_action :test_valid

  def index
    @bills = @current_user.bills.page(params[:page])
  end
  # # GET /weixin_web/bills/1
  # # GET /weixin_web/bills/1.json
  # def show
  # end
  #def test_valid
  #  render :text => 'error' ,status: 200
  #end

  def get_items
    render json: @current_user.items.where(flag: params[:bill_type_id])
  end
  # # GET /weixin_web/bills/new
  # def new
  #   @weixin_web_bill = WeixinWeb::Bill.new
  # end

  # # GET /weixin_web/bills/1/edit
  # def edit
  # end

  # # POST /weixin_web/bills
  # # POST /weixin_web/bills.json
  # def create
  #   @weixin_web_bill = WeixinWeb::Bill.new(weixin_web_bill_params)

  #   respond_to do |format|
  #     if @weixin_web_bill.save
  #       format.html { redirect_to @weixin_web_bill, notice: 'Bill was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @weixin_web_bill }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @weixin_web_bill.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /weixin_web/bills/1
  # # PATCH/PUT /weixin_web/bills/1.json
  # def update
  #   respond_to do |format|
  #     if @weixin_web_bill.update(weixin_web_bill_params)
  #       format.html { redirect_to @weixin_web_bill, notice: 'Bill was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @weixin_web_bill.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /weixin_web/bills/1
  # # DELETE /weixin_web/bills/1.json
  # def destroy
  #   @weixin_web_bill.destroy
  #   respond_to do |format|
  #     format.html { redirect_to weixin_web_bills_url }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_weixin_web_bill
  #     @weixin_web_bill = WeixinWeb::Bill.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def weixin_web_bill_params
  #     params[:weixin_web_bill]
  #   end
end
