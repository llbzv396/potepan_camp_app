class Potepan::HomeController < ApplicationController
  COUNT_OF_LATED_PRODUCTS = 8
  def index
    @lated_products = Spree::Product.including_images_prices.
      order(available_on: :desc).limit(COUNT_OF_LATED_PRODUCTS)

    @shirts = Spree::Taxon.find_by(permalink: "categories/clothing/t-shirt") ||
              Spree::Taxon.find_by(name: "Tシャツ")
    @bags = Spree::Taxon.find_by(permalink: "categories/bags") || Spree::Taxon.find_by(name: "バッグ")
    @mugs = Spree::Taxon.find_by(permalink: "categories/mugs") || Spree::Taxon.find_by(name: "マグ")
  end

  def unfinished
  end
end
