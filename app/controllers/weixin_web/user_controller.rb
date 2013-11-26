class WeixinWeb::UserController < WeixinWeb::ApplicationController

  with_options :only => :bind do 
    skip_before_action :current_wuser 
    skip_before_action :current_user 
  end
  def signup    
  end

  def signin    
  end

  def bind      
    if params[:flag] == 'signin'
      user = User.find_first_by_auth_conditions(params[:user])
      if user.valid_password?(params[:user][:password])
        @current_wuser.user = user
        if @current_wuser.save
          return render text: '绑定成功！', layout: false, status: 200
        end
      end
    else
      user = User.new(user_params)
      if user.save!
        @current_wuser.user = user
        if @current_wuser.save
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
