class Potepan::ProductsController < ApplicationController
  def index
    @new_products = Spree::Product.including_images_prices.
      order(available_on: :desc).limit(5)
  end

  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @product_images = @product.images
    @related_products = Spree::Product.related_products(@product).
      including_images_prices.distinct.limit(4)
  end
end
