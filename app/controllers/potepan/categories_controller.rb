class Potepan::CategoriesController < ApplicationController

  def show
    @taxons = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all
  end

end
