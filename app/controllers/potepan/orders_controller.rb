class Potepan::OrdersController < ApplicationController
  helper_method :products_count
  def show
    @order = Potepan::Order.find(params[:id])
    product_ids = Potepan::OrderedProduct.where(order_id: params[:id]).pluck(:product_id)
    @products = Spree::Product.where(id: product_ids)
    @item_total = 0
    @products.each do |product|
      if products_count(product.id) == 1
        @item_total += (product.price * 110).to_i
      else
        @item_total += products_count(product.id).to_i * (product.price * 110).to_i
      end
    end
  end

  def create
    order = Potepan::Order.find_by(user_id: current_user.id, state: 1)
    product = Spree::Product.find(params[:id])
    orderedproduct = Potepan::OrderedProduct.find_by(order_id: order.id, product_id: params[:id])

    if order.present? && orderedproduct.present?
      orderedproduct.count += 1
    elsif order.present?
      orderedproduct = Potepan::OrderedProduct.new
      orderedproduct.order_id = order.id
      orderedproduct.product_id = product.id
      orderedproduct.count = 1
      orderedproduct.save
    else
      order = Potepan::Order.new
      order.user_id = current_user.id
      order.state = 1
      order.save
      orderedproduct = Potepan::OrderedProduct.new
      orderedproduct.order_id = order.id
      orderedproduct.product_id = product.id
      orderedproduct.count = 1
    end

    if orderedproduct.save
      redirect_to potepan_order_path(order.id)
    else
      redirect_to potepan_order_path(order.id)
    end
  end

  def update
    orderedproducts = Potepan::OrderedProduct.where(order_id: params[:id])
    orderedproducts.each do |orderedproduct|
      # orderedproduct.count =
    end
    redirect_to potepan_order_path(params[:id])
  end

  def destroy
    order_id = params[:id]
    product_id = params[:product_id]
    Potepan::OrderedProduct.find_by(order_id: order_id, product_id: product_id).delete
    redirect_to potepan_order_path(order_id)
  end

  def step1
    order = Potepan::OrderedProduct.find_by(order_id: params[:id])
    if order.nil?
      flash[:danger] = "カートに商品が入っていません"
      redirect_to potepan_order_path(params[:id])
    end
    @checkout = Potepan::Checkout.new
  end

  def data_set
    @checkout = Potepan::Checkout.find_by(order_id: params[:id])
    @checkout = Potepan::Checkout.new if @checkout.nil?
    user = Potepan::Order.find(params[:id]).user
    if params[:check_name].nil?
      @checkout.name = params[:potepan_checkout][:name]
    else
      @checkout.name = user.name
    end
    if params[:check_email].nil? && @checkout.email.nil?
      @checkout.email = params[:potepan_checkout][:email]
    else
      @checkout.email = user.email
    end
    if params[:check_streetaddress].nil? && @checkout.streetaddress.nil?
      @checkout.streetaddress = params[:potepan_checkout][:streetaddress]
    else
      @checkout.streetaddress = user.streetaddress
    end
    if params[:check_phone].nil? && @checkout.phone.nil?
      @checkout.phone = params[:potepan_checkout][:phone]
    else
      @checkout.phone = user.phone
    end
    if params[:check_postal].nil? && @checkout.postal.nil?
      @checkout.postal = params[:potepan_checkout][:postal]
    else
      @checkout.postal = user.postal
    end
    @checkout.order_id = params[:id]
    @checkout.state = 1
    if @checkout.save
      redirect_to step2_potepan_order_path
    else
      flash.now[:danger] = 'お届け先情報を登録に失敗しました'
      render 'step1'
    end
  end

  def step2
  end

  def step3
    @order = Potepan::Order.find(params[:id])
    @user = @order.user
    @checkout = Potepan::Checkout.find_by(order_id: @order.id)
    product_ids = Potepan::OrderedProduct.where(order_id: params[:id]).pluck(:product_id)
    @products = Spree::Product.where(id: product_ids)
    @item_total = 0
    @products.each do |product|
      if products_count(product.id) == 1
        @item_total += (product.price * 110).to_i
      else
        @item_total += products_count(product.id).to_i * (product.price * 110).to_i
      end
    end
  end

  def complete
    @order = Potepan::Order.find(params[:id])
    @checkout = Potepan::Checkout.find_by(order_id: @order.id)
    @order.state = 2
    @order.save
    @checkout.state = 2
    @checkout.save
  end

  private

  def products_count(id)
    Potepan::OrderedProduct.find_by(product_id: id).count
  end
end
