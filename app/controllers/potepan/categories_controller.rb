class Potepan::CategoriesController < ApplicationController

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    # @taxons自信+以下のカテゴリ全てのidを配列で返す => それで検索をかける
    @products = Spree::Product.includes(master: [:images]).in_taxon(@taxon)
  end

end
