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

  def missing
    if current_wxuser.user
      @content     = Material.try_content :missing_content
      @weixin_type = 'text' 
    else      
      next_action = current_wxuser.next_actions.where(key_word: weixin_params.content).first      
      if next_action
        current_wxuser.signature = params[:signature]
        current_wxuser.save
        #@weixin_type    = next_action.weixin_type
        @content  = next_action.remark
        @content << next_action.content
        if next_action.weixin_type == 'link'
          @content.sub!(/\?$/,'')
          @content << "?signature=#{params[:signature]}&weixin_id=#{weixin_params.from_user}"          
        end
        return
      end
      current_wxuser.sigin_up_and_bind
      @weixin_type = 'text'
      @content = ''      
      current_wxuser.next_actions.each do |na|
        @content << "#{na.key_word} #{na.remark}\n"
      end
    	@content
    end
  end

  def help    
    @weixin_type = 'text'
    current_wxuser.next_actions.each do |na|
      @content << "#{na.key_word} #{na.remark}\n"
    end
    @content = "#{@content} #{Material.try_content :help}"
  end

end
