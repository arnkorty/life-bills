require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe WeixinUsersController do

  # This should return the minimal set of attributes required to create a valid
  # WeixinUser. As you add validations to WeixinUser, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "user" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WeixinUsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all weixin_users as @weixin_users" do
      weixin_user = WeixinUser.create! valid_attributes
      get :index, {}, valid_session
      assigns(:weixin_users).should eq([weixin_user])
    end
  end

  describe "GET show" do
    it "assigns the requested weixin_user as @weixin_user" do
      weixin_user = WeixinUser.create! valid_attributes
      get :show, {:id => weixin_user.to_param}, valid_session
      assigns(:weixin_user).should eq(weixin_user)
    end
  end

  describe "GET new" do
    it "assigns a new weixin_user as @weixin_user" do
      get :new, {}, valid_session
      assigns(:weixin_user).should be_a_new(WeixinUser)
    end
  end

  describe "GET edit" do
    it "assigns the requested weixin_user as @weixin_user" do
      weixin_user = WeixinUser.create! valid_attributes
      get :edit, {:id => weixin_user.to_param}, valid_session
      assigns(:weixin_user).should eq(weixin_user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new WeixinUser" do
        expect {
          post :create, {:weixin_user => valid_attributes}, valid_session
        }.to change(WeixinUser, :count).by(1)
      end

      it "assigns a newly created weixin_user as @weixin_user" do
        post :create, {:weixin_user => valid_attributes}, valid_session
        assigns(:weixin_user).should be_a(WeixinUser)
        assigns(:weixin_user).should be_persisted
      end

      it "redirects to the created weixin_user" do
        post :create, {:weixin_user => valid_attributes}, valid_session
        response.should redirect_to(WeixinUser.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved weixin_user as @weixin_user" do
        # Trigger the behavior that occurs when invalid params are submitted
        WeixinUser.any_instance.stub(:save).and_return(false)
        post :create, {:weixin_user => { "user" => "invalid value" }}, valid_session
        assigns(:weixin_user).should be_a_new(WeixinUser)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        WeixinUser.any_instance.stub(:save).and_return(false)
        post :create, {:weixin_user => { "user" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested weixin_user" do
        weixin_user = WeixinUser.create! valid_attributes
        # Assuming there are no other weixin_users in the database, this
        # specifies that the WeixinUser created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        WeixinUser.any_instance.should_receive(:update).with({ "user" => "" })
        put :update, {:id => weixin_user.to_param, :weixin_user => { "user" => "" }}, valid_session
      end

      it "assigns the requested weixin_user as @weixin_user" do
        weixin_user = WeixinUser.create! valid_attributes
        put :update, {:id => weixin_user.to_param, :weixin_user => valid_attributes}, valid_session
        assigns(:weixin_user).should eq(weixin_user)
      end

      it "redirects to the weixin_user" do
        weixin_user = WeixinUser.create! valid_attributes
        put :update, {:id => weixin_user.to_param, :weixin_user => valid_attributes}, valid_session
        response.should redirect_to(weixin_user)
      end
    end

    describe "with invalid params" do
      it "assigns the weixin_user as @weixin_user" do
        weixin_user = WeixinUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WeixinUser.any_instance.stub(:save).and_return(false)
        put :update, {:id => weixin_user.to_param, :weixin_user => { "user" => "invalid value" }}, valid_session
        assigns(:weixin_user).should eq(weixin_user)
      end

      it "re-renders the 'edit' template" do
        weixin_user = WeixinUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WeixinUser.any_instance.stub(:save).and_return(false)
        put :update, {:id => weixin_user.to_param, :weixin_user => { "user" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested weixin_user" do
      weixin_user = WeixinUser.create! valid_attributes
      expect {
        delete :destroy, {:id => weixin_user.to_param}, valid_session
      }.to change(WeixinUser, :count).by(-1)
    end

    it "redirects to the weixin_users list" do
      weixin_user = WeixinUser.create! valid_attributes
      delete :destroy, {:id => weixin_user.to_param}, valid_session
      response.should redirect_to(weixin_users_url)
    end
  end

end
