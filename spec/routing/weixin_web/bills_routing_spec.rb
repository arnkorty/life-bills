require "spec_helper"

describe WeixinWeb::BillsController do
  describe "routing" do

    it "routes to #index" do
      get("/weixin_web/bills").should route_to("weixin_web/bills#index")
    end

    it "routes to #new" do
      get("/weixin_web/bills/new").should route_to("weixin_web/bills#new")
    end

    it "routes to #show" do
      get("/weixin_web/bills/1").should route_to("weixin_web/bills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weixin_web/bills/1/edit").should route_to("weixin_web/bills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weixin_web/bills").should route_to("weixin_web/bills#create")
    end

    it "routes to #update" do
      put("/weixin_web/bills/1").should route_to("weixin_web/bills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weixin_web/bills/1").should route_to("weixin_web/bills#destroy", :id => "1")
    end

  end
end
