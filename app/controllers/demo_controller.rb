class DemoController < ApplicationController
  include Split::Helper

  def index
    # A/B test experiments
    @background_color = ab_test(:background_color)
    @heading_font = ab_test(:heading_font)
    @layout_style = ab_test(:layout_style)
  end

  def button_click
    # Track goal when button is clicked
    ab_finished(:button_clicked)
    redirect_to demo_index_path, notice: "Button clicked! Goal tracked."
  end
end
