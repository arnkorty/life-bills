class WeixinController < ActionController::Base
  before_action :weixin_params
  before_action :set_xml_format
  layout 'weixin'
  def signature
    array = [Settings.weixin_token, params[:timestamp], params[:nonce]].sort    
    if params[:signature] != Digest::SHA1.hexdigest(array.join)
      render :text => "Forbidden", :status => 403 
    else
      render :text => params[:echostr], :status => 200, layout: false
    end
  end

  def event
    
  end

  private
  def weixin_params
    @weixin_params ||= WeixinRails::Paramers.new(params)
  end

  def set_xml_format
    request.formats = [:xml]
  end
end
