  class Potepan::ProductsController < ApplicationController
    def show
      # Spree::Productから製品に関する情報を取得
      @product = Spree::Product.find(params[:id])
      # Spree::ProductPropertyとSpree::Propertyから製品の詳細な情報を取得
      @product_properties = @product.product_properties.includes(:property)
      # 画像を表示させるためのデータを取得
      @product_images = @product.images
    end
  end
