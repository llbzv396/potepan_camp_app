class Potepan::ProductsController < ApplicationController
  def show
    # Spree::Productから製品に関する情報を取得
    @product = Spree::Product.friendly.find(params[:id])
    # Spree::ProductPropertyとSpree::Propertyから製品の詳細な情報を取得
    @product_properties = @product.product_properties.includes(:property)
    # 画像を表示させるためのデータを取得
    @product_images = @product.images
    # 表示している商品のカテゴリを取得
    @taxon = @product.taxons.where(taxonomy_id: 1)
    # そのカテゴリのtaxon.idを使ってclassificationから商品の一覧を検索
    @related = Spree::Classification.where(taxon_id: @taxon.ids)
    @related_products = Spree::Product.where(id: @related.all.map(&:product_id))
  end
end
