class Potepan::HomeController < ApplicationController
  COUNT_OF_LATED_PRODUCTS = 8
  def index
    @lated_products = Spree::Product.including_images_prices.
      order(available_on: :desc).limit(COUNT_OF_LATED_PRODUCTS)
  end
end
