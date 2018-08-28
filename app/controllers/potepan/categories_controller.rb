class Potepan::CategoriesController < ApplicationController

  def show
    @taxons = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all
    if @taxons.root?
      @products = @taxons.leaves
    else
      @products = @taxons.products
    end
  end

end
