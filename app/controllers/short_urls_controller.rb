class ShortUrlsController < ApplicationController
  before_action :set_recent_urls, only: [:new, :create]

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    @short_url.short_code = generate_unique_code

    if @short_url.save
      redirect_to root_path, notice: "URL acortada con éxito"
    else
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

  def generate_unique_code
    loop do
      code = SecureRandom.alphanumeric(7)
      break code unless ShortUrl.exists?(short_code: code)
    end
  end

  def set_recent_urls
    @recent_urls = ShortUrl.order(created_at: :desc)
  end
end
