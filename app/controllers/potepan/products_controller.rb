class Potepan::ProductsController < ApplicationController
  COUNT_OF_RELATED_PRODUCTS = 4
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @product_images = @product.images
    @related_products = Spree::Product.related_products(@product).
      including_images_prices.distinct.limit(COUNT_OF_RELATED_PRODUCTS)
  end
end
