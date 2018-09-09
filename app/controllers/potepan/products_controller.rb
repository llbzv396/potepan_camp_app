class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @product_images = @product.images
    @related_products = Spree::Product.related_products(@product).
      including_images_prices.distinct.limit(4)
  end
end
