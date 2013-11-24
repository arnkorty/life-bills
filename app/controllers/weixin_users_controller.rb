class WeixinUsersController < ApplicationController
  before_action :set_weixin_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  # GET /weixin_users
  # GET /weixin_users.json
  def index
    @weixin_users = WeixinUser.all
  end

  # GET /weixin_users/1
  # GET /weixin_users/1.json
  def show
  end

  # GET /weixin_users/new
  def new
    @weixin_user = WeixinUser.new
  end

  # GET /weixin_users/1/edit
  def edit
  end

  # POST /weixin_users
  # POST /weixin_users.json
  def create
    @weixin_user = WeixinUser.new(weixin_user_params)

    respond_to do |format|
      if @weixin_user.save
        format.html { redirect_to @weixin_user, notice: 'Weixin user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weixin_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @weixin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weixin_users/1
  # PATCH/PUT /weixin_users/1.json
  def update
    respond_to do |format|
      if @weixin_user.update(weixin_user_params)
        format.html { redirect_to @weixin_user, notice: 'Weixin user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weixin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weixin_users/1
  # DELETE /weixin_users/1.json
  def destroy
    @weixin_user.destroy
    respond_to do |format|
      format.html { redirect_to weixin_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weixin_user
      @weixin_user = WeixinUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weixin_user_params
      params.require(:weixin_user).permit(:user_id, :name, :delete_flag)
    end
end
