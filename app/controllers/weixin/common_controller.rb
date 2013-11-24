class Weixin::CommonController < Weixin::ApplicationController
  # skip_before_action :request_valid?, :only => :signature
  # skip_before_action :set_xml_format, :only => :signature
  with_options :only => :signature do |c| 
    c.skip_before_action :request_valid?
    c.skip_before_action :set_xml_format
  end
  def signature
    if params_valid?
      render :text => params[:echostr], :status => 200, layout: false
    else
      render :text => "Forbidden", :status => 403 
    end
  end
end
