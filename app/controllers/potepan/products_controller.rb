class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @product_images = @product.images
    @related_products = Spree::Product.joins(:taxons).
      includes(master: [:images, :default_price]).
      where(spree_taxons: { id: @product.taxons.ids }).
      where.not(id: @product.id).distinct
  end
end
