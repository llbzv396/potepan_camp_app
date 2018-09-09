class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @products = Spree::Product.including_images_prices.in_taxon(@taxon)
  end
end
