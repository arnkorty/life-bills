require 'spec_helper'

describe WeixinWeb::UserController do

  describe "GET 'signup_and_bind'" do
    it "returns http success" do
      get 'signup_and_bind'
      response.should be_success
    end
  end

  describe "GET 'bind'" do
    it "returns http success" do
      get 'bind'
      response.should be_success
    end
  end

end
