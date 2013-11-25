class Weixin::ApplicationController < ActionController::Base

  before_action :weixin_params
  before_action :set_xml_format
  before_action :request_valid?
  
  layout 'weixin'

  def event
    
  end

  private
  def params_valid?
    array = [Settings.weixin_token, params[:timestamp]||'0', params[:nonce]||'0'].sort    
    params[:signature] == Digest::SHA1.hexdigest(array.join)    
  end

  def request_valid?
    unless params_valid?
      render :text => "Forbidden", :status => 403 
    end
  end
  def weixin_params
    @weixin_params ||= WeixinRails::Paramers.new(params)
  end

  def set_xml_format
    request.formats = [:xml]
	end 
	
	def current_wxuser    
		@current_wuxsser ||= WeixinUser.find_or_create_by(weixin_id: weixin_params.from_user)    
	end

end
