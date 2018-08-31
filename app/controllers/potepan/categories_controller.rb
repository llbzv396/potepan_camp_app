class Potepan::CategoriesController < ApplicationController

  def show
    @taxons = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all
    # @taxons自信+以下のカテゴリ全てのidを配列で返す => それで検索をかける
    @products = Spree::Product.in_taxon(@taxons)
  end

end
