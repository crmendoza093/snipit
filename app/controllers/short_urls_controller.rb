class ShortUrlsController < ApplicationController
  before_action :set_recent_urls, only: [ :new, :create ]

  def new
    @short_url = ShortUrl.new
  end

  def create
    service = ShortUrlCreator.new(original_url: short_url_params[:original_url])
    @short_url = service.call
  
    if @short_url.persisted?
      redirect_to root_path, notice: "URL acortada con éxito"
    else
      flash.now[:alert] = "Error al acortar la URL"
      render :new, status: :unprocessable_entity
    end
  end

  def stats
    @short_url = ShortUrl.find_by!(short_code: params[:short_code])
    @stats = UrlStatsService.new(@short_url).call
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url)
  end

  def set_recent_urls
    @recent_urls = ShortUrl.order(created_at: :desc)
  end
end
