require "spec_helper"

describe WeixinUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/weixin_users").should route_to("weixin_users#index")
    end

    it "routes to #new" do
      get("/weixin_users/new").should route_to("weixin_users#new")
    end

    it "routes to #show" do
      get("/weixin_users/1").should route_to("weixin_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weixin_users/1/edit").should route_to("weixin_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weixin_users").should route_to("weixin_users#create")
    end

    it "routes to #update" do
      put("/weixin_users/1").should route_to("weixin_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weixin_users/1").should route_to("weixin_users#destroy", :id => "1")
    end

  end
end
