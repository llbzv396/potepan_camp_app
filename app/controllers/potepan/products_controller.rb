class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @product_images = @product.images
  end
end
