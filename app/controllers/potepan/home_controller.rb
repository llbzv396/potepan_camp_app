class Potepan::HomeController < ApplicationController
  def index
    @new_products = Spree::Product.including_images_prices.order(available_on: :desc).limit(5)
  end
end
