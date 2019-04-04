class Potepan::ProductsController < ApplicationController
  COUNT_OF_RELATED_PRODUCTS = 4
  def show
    @product = Spree::Product.friendly.find(params[:slug_or_id])
    @product_properties = @product.product_properties.includes(:property)
    @related_products = Spree::Product.related_products(@product).
      including_images_prices.limit(COUNT_OF_RELATED_PRODUCTS)
  end

  def add_favorite
    product = Spree::Product.find(params[:slug_or_id])
    user = Potepan::User.find(current_user.id)
    favorite = Potepan::Favorite.find_by(user_id: user.id, product_id: product.id)
    if favorite.present?
      flash[:danger] = "既にお気に入りに登録されています"
    else
      favorite = Potepan::Favorite.new
      favorite.user_id = user.id
      favorite.product_id = product.id
      if favorite.save
        flash[:success] = "お気に入りに追加しました"
      else
        flash[:danger] = "お気に入りに登録できませんでした"
      end
    end
    redirect_to potepan_path
  end

  def remove_favorite
    Potepan::Favorite.find_by(user_id: current_user.id, product_id: params[:slug_or_id]).delete
    flash[:danger] = "お気に入りから削除しました"
    redirect_to potepan_path
  end
end
