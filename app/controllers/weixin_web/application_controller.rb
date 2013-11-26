class WeixinWeb::ApplicationController < ActionController::Base
  layout 'weixin_web'
  # skip_before_action :verify_authenticity_token    
#   before_action :current_wuser
#   before_action :current_user 
  before_action :valid_request?
  #before_action :request_user?

  private
  def current_wuser
    @current_wuser ||= WeixinUser.where(weixin_id: params[:weixin_id]).first    
  end
  def current_user
    if current_wuser
      @current_user ||= current_wuser.user
    end
  end
  def valid_request?
    if current_wuser.signature != params[:signature]
      render text: 'Sorry,你访问的地址过去,请重新获取地址！', status: 422
      return
    end
  end 
  def request_user?
    return render text: 'Sorry,此功能必须绑定用户！', statu: 422 unless current_user
  end

  
end
