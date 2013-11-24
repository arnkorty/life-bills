class Weixin::EventsController < Weixin::ApplicationController
  def subscribe
    @weixin_type    = 'text'
    @content = Material.subscribe
  end
end
