class UrlStatsService
  attr_reader :short_url, :stats

  def initialize(short_url)
    @short_url = short_url
    @stats = {}
  end

  def call
    prepare_basic_stats
    prepare_country_stats

    stats
  end

  private

  def prepare_basic_stats
    visits = short_url.visits.order(created_at: :desc)

    stats[:visits] = visits
    stats[:total_visits] = visits.count
    stats[:created_at] = short_url.created_at
    stats[:recent_visit] = visits.first
  end

  def prepare_country_stats
    visits = short_url.visits.reorder("")

    # Data country
    country_counts = visits.group(:country).count
    stats[:top_country] = country_counts.max_by { |k, v| v }&.first

    # Data country stats
    stats[:country_stats] = country_counts.sort_by { |k, v| -v }
  end
end
