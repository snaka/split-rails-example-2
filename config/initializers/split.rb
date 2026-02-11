require 'split'
require 'split/dashboard'

Split.configure do |config|
  config.db_failover = true
  config.db_failover_on_db_error = proc { |error| Rails.logger.error(error.message) }
  config.allow_multiple_experiments = true
  config.enabled = true

  config.persistence = :cookie
  config.persistence_cookie_length = 2592000

  config.dashboard_pagination_default_per_page = 100
  config.cache = true

  # Define A/B test experiments
  config.experiments = {
    "background_color" => {
      alternatives: ["white", "lightblue", "lightgreen"],
      goals: ["button_clicked"]
    },
    "heading_font" => {
      alternatives: ["serif", "sans-serif", "monospace"],
      goals: ["button_clicked"]
    },
    "layout_style" => {
      alternatives: ["centered", "left", "right"],
      goals: ["button_clicked"]
    }
  }
end

# Basic authentication for Split Dashboard
Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'secret'
end
