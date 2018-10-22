class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @products = Spree::Product.includes(master: [:images, :default_price]).in_taxon(@taxon)
  end
end
