class BillsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_user.bills.includes(:person,:account,:item)
    if params[:search].blank? && params[:from].blank?      
      session[:search_bills] = nil
    else
      session[:search_bills] ||= {}
      unless ['search','create'].include?(params[:from])
        # @bills = Bill.all        
        if params[:search].is_a?(Array)
          params[:search].each do |s|
            session[:search_bills] ||= {}
            s.each do |key,value|            
              if value.is_a?(Array)
                session[:search_bills][key.to_sym] = {} if session[:search_bills][key.to_sym].blank? || !session[:search_bills][key.to_sym].is_a?(Hash)
                value.each do |v| 
                  #@bills = @bills.where(key.to_sym.send(v[:target] || :gte ) => v[:value])
                  session[:search_bills][key.to_sym][v[:target]] = v[:value]
                end
              else
                session[:search_bills][key.to_sym] = value
              end
            end
          end
        else
          session[:search_bills].delete(params[:search][:clean].to_sym) if params[:search].is_a? Hash
        end
      end
      session[:search_bills].each do |key,value|
        key_sym = key.to_sym
        if value.is_a?(Hash)
          value.each do |k1, v1|
            @bills = @bills.where(key_sym.send(k1 ) => v1)
          end            
        else 
          if value.is_a?(Array)                                    
            @bills = @bills.where(key_sym.in => value)            
          else
            @bills = @bills.where(key_sym=> (key_sym == :remark ? Regexp.new(value) : value))
          end
        end
      end
    end
    @bills_infos = {}
    @bills_infos[:money]  = @bills.sum(:money)
    @bills_infos[:size]   = @bills.size
    @bills_infos[:income] = @bills.where(bill_type_id: Settings.bill_types.income).sum(:money)
    @bills_infos[:outlay] = @bills.where(bill_type_id: Settings.bill_types.outlay).sum(:money)
    @bills_infos[:lend]   = @bills.where(bill_type_id: Settings.bill_types.lend).sum(:money)
    @bills_infos[:borrow] = @bills.where(bill_type_id: Settings.bill_types.borrow).sum(:money)
    if params[:order] && params[:order].is_a?(String)
      order = params[:order].split('.')
      if ['desc', 'asc'].include?(order[-1])
        @bills = @bills.send(order[-1],order[0])
      end      
    end
    @bills   = @bills.desc(:created_at).page(params[:page])
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
    render :partial=>'bill_form', locals: {name: @bill.bill_type_name || '', name_en: @bill.bill_type_name_en || ''}
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = current_user.bills.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bills_path(from: :create), notice: '成功创建账单' }
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
        format.json { render  action: 'show', status: :created, location: @bill }
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

  def search
    if params[:bill]
      session[:search_bills] = {}
      params[:bill].each do |key, value|
        
        value.delete_if{|v| v.blank? } if value.is_a?(Array)
        value.delete_if{|_, v| v.blank? } if value.is_a?(Hash)
      
        # value = Regexp.new(value) if key.to_sym == :remark && !value.blank?
        session[:search_bills][key.to_sym] = value unless value.blank?
        # case value.class
        # when String
        #   session[:search_bills][key] = value
        # when Array
        #   value.delete_if{|v| v.blank? }
        #   session[:search_bills][key] = value
        # when Hash                       
        #   session[:search_bills][key] = value
        # end
      end
      # params.each do ||
    end
    # Rails.logger.warn session[:search_bills].to_json
    # redirect_to bills_path(from: 'search')
    redirect_to bills_path(from: 'search')
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
