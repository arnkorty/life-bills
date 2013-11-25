class WeixinWeb::UserController < WeixinWeb::ApplicationController
  def signup    
  end

  def signin    
  end

  def bind  
    
    if params[:weixin_id]
      wuser = WeixinUser.where(weixin_id: params[:weixin_id]).first
      if wuser && wuser.signature != params[:signature]
        return render text: '绑定出现出错，请检查你的数据', layout: false, status: 422
      end
    else
      return render text: '绑定出现出错，请检查你的数据', layout: false, status: 422
    end

    wuser ||= WeixinUser.new(weixin_id: params[:weixin_id])
    if params[:flag] == 'signin'
      user = User.find_first_by_auth_conditions(params[:user])
      if user.valid_password?(params[:user][:password])
        wuser.user = user
        if wuser.save
          return render text: '绑定成功！', layout: false, status: 200
        end
      # else
        # return render text: 'error4', layout: false, status: 422
      end
    else
      user = User.new(user_params)
      if user.save!
        wuser.user = user
        if wuser.save
          return render text: '绑定成功！', layout: false, status: 200
        end
      end
    end
    return render text: '绑定出错，请检查你的帐号信息！', layout: false, status: 422
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
