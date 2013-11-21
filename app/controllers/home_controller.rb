class HomeController < ApplicationController	  
  def index
    @bills = current_user.bills.bills_in_current_month
  end
end
