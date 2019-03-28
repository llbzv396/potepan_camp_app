class Potepan::OrdersController < ApplicationController
  def show
    @order = Potepan::Order.find_by(user_id: current_user.id, state: 1)
    product_ids = Potepan::OrderedProduct.where(order_id: params[:id]).pluck(:product_id)
    @products = Spree::Product.where(id: product_ids)
    @item_total = 0
    @products.each do |product|
      @item_total += (product.price * 110).to_i
    end
  end

  def create
    order = Potepan::Order.find_by(user_id: current_user.id, state: 1)
    product = Spree::Product.find(params[:id])
    if order
      # 既に同じユーザーのカート情報が保存されている場合
      tmp = Potepan::OrderedProduct.new
      tmp.order_id = order.id
      tmp.product_id = product.id
      tmp.save
    else
      # 新しくカート情報が作られる場合
      order = Potepan::Order.new
      order.user_id = current_user.id
      order.state = 1
      order.save

      tmp = Potepan::OrderedProduct.new
      tmp.order_id = order.id
      tmp.product_id = product.id
      tmp.save
    end
    redirect_to potepan_order_path(order.id)
  end

  def update
  end

  def edit
  end
end
