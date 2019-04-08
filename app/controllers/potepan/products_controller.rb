class Potepan::ProductsController < ApplicationController
  before_action :check_logged_in, only: [:add_favorite, :remove_favorite]
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
      render 'add_favorite_false_01'
    else
      favorite = Potepan::Favorite.new
      favorite.user_id = user.id
      favorite.product_id = product.id
      if favorite.save
        render 'add_favorite'
      else
        render 'add_favorite_false_02'
      end
    end
  end

  def remove_favorite
    Potepan::Favorite.find_by(user_id: current_user.id, product_id: params[:slug_or_id]).delete
    flash[:danger] = "お気に入りから削除しました"
    redirect_back(fallback_location: potepan_path)
  end

  private
  def check_logged_in
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      render :js => "window.location = '/potepan'"
    end
  end
end
