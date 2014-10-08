class WeixinWeb::BillsController < WeixinWeb::ApplicationController
  before_action :set_weixin_web_bill, only: [:show, :edit, :update, :destroy]
  # # GET /weixin_web/bills
  # # GET /weixin_web/bills.json 

  skip_before_action :valid_request?, only: :index
	
	before_action :request_user?, except: :index

  def index
    if current_user
      @bills   = current_user.is_a?(User)? current_user.bills : current_user.user.bills
    else
      @bills   = Bill.where(:bill_time.gte => Time.now - 1.year)
    end
    @total_money = @bills.sum(:money)
    if params[:search]

    end
    @bills       = @bills.desc(:bill_time).page(params[:page])
  end
  # # GET /weixin_web/bills/1
  # # GET /weixin_web/bills/1.json
  # def show
  # end
  #def test_valid
  #  render :text => 'error' ,status: 200
  #end

  def get_items
    render json: current_user.items.where(flag: params[:bill_type_id])
  end
  # # GET /weixin_web/bills/new
	 def new
#     @weixin_web_bill = WeixinWeb::Bill.new
    @bill = current_user.bills.new
	 end

  # GET /weixin_web/bills/1/edit
  def edit
    # @bill = current_user.bills.find    
  end

  # # POST /weixin_web/bills
  # # POST /weixin_web/bills.json
  def create
    @bill = current_user.bills.new(weixin_web_bill_params)
    @bill.user = current_user.user
    respond_to do |format|
      if @bill.save
        format.html { redirect_to weixin_web_bills_path(weixin_id: params[:weixin_id],signature: params[:signature]), notice: 'Bill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weixin_web_bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @weixin_web_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /weixin_web/bills/1
  # # PATCH/PUT /weixin_web/bills/1.json
  def update
    if @bill.is_enable || (@bill.person != current_user && @bill.user != current_user) 
       redirect_to weixin_web_bills_path(weixin_id: params[:weixin_id], signature: params[:signature])
    end
    respond_to do |format|
      if @bill.update(weixin_web_bill_params)
        format.html { redirect_to weixin_web_bills_path(weixin_id: params[:weixin_id], signature: params[:signature]), notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weixin_web_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /weixin_web/bills/1
  # # DELETE /weixin_web/bills/1.json
  def destroy
    if (@bill.is_enable) || (@bill.person != current_user && @bill.user != current_user) 
       redirect_to weixin_web_bills_url
    end
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to weixin_web_bills_path(weixin_id: params[:weixin_id], signature: params[:signature]) }
      format.json { head :no_content }
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_weixin_web_bill
      @bill = current_user.bills.find(params[:id])
    end

  #   # Never trust parameters from the scary internet, only allow the white list through.
    def weixin_web_bill_params
      params.require(:bill).permit(:item_id, :account_id, :person_id, :money, :bill_time, :remark, :bill_type_id)
      # params[:weixin_web_bill]
    end
end
