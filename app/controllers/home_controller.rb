class HomeController < ApplicationController	  
  skip_before_action :authenticate_user!
  def index
    if user_signed_in?
      @bills = current_user.bills.bills_in_current_month      
    else
      render action: 'page'
    end
  end
end
