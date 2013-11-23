class WeixinController < ActionController::Base
  def text
  end

  def image
  end

  def signature
    array = [Settings.weixin_token, params[:timestamp], params[:nonce]].sort    
    if params[:signature] != Digest::SHA1.hexdigest(array.join)
      render :text => "Forbidden", :status => 403 
    else
      render :text => params[:echostr], :status => 200, layout: false
    end
  end
end
