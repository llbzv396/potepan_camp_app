class Potepan::ProductsController < ApplicationController
  COUNT_OF_RELATED_PRODUCTS = 4
  def show
    @product = Spree::Product.friendly.find(params[:slug_or_id])
    @product_properties = @product.product_properties.includes(:property)
    @related_products = Spree::Product.related_products(@product).
      including_images_prices.limit(COUNT_OF_RELATED_PRODUCTS)
  end
end
