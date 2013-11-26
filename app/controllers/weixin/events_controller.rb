class Weixin::EventsController < Weixin::ApplicationController
  def subscribe
    @weixin_type    = 'text'
    @content = Material.try_content :subscribe
	end 

	def unsubscribe
		wuser = WeixinUser.where(weixin_id: weixin_params.to_user).first
		wuser.destroy 
		render inline: "OK", status: 200
	end	
end
