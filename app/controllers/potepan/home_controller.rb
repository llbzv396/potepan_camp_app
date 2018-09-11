class Potepan::HomeController < ApplicationController
  def index
    @lated_products = Spree::Product.including_images_prices.order(available_on: :desc).limit(5)
  end
end
