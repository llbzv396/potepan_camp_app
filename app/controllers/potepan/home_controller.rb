class Potepan::HomeController < ApplicationController
  COUNT_OF_LATED_PRODUCTS = 8
  def index
    @lated_products = Spree::Product.including_images_prices.
      order(available_on: :desc).limit(COUNT_OF_LATED_PRODUCTS)

    @shirts = Spree::Taxon.find_by(name: "Shirts")
    @bags = Spree::Taxon.find_by(name: "Bags")
    @mugs = Spree::Taxon.find_by(name: "Mugs")
  end
end
