class UrlController < ApplicationController 
	skip_before_filter :authenticate_user!
  def index
    url = ShortUrl.get_url(params[:url])
    if url
      redirect_to url
    else
      render inline: 'error', status: 422
    end
  end
end
