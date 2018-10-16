class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:slug_or_id])
    @product_properties = @product.product_properties.includes(:property)
  end
end
