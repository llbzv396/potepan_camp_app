class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @products = Spree::Product.including_images_prices.in_taxon(@taxon)
    @options = Spree::OptionType.all.includes(:option_values)
  end
end
