class RedirectionsController < ApplicationController
  def show
    @short_url = ShortUrl.find_by(short_code: params[:short_code])

    if @short_url
      VisitTracker.new(short_url: @short_url, request: request).call
      redirect_to @short_url.original_url, allow_other_host: true
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end
end
