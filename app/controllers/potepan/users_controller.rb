class Potepan::UsersController < ApplicationController
  helper_method :bought_date, :bought_products, :bought_price
  def show
    @user = Potepan::User.find(params[:id])
    @orders = Potepan::Order.where(user_id: current_user.id, state: 2)
    @favorite_products = @user.favorites
  end

  def new
    @user = Potepan::User.new
  end

  def create
    @user = Potepan::User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "会員登録が完了しました"
      redirect_to potepan_path
    else
      render 'new'
    end
  end

  def edit
    @user = Potepan::User.find(params[:id])
  end

  def update
    @user = Potepan::User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "登録情報を更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    Potepan::User.find(params[:id]).destroy
    flash[:success] = "退会手続きが完了しました"
    redirect_to potepan_path
  end

  private

  def user_params
    params.require(:potepan_user).permit(:name, :email, :password,
                                         :password_confirmation,
                                         :postal, :streetaddress, :phone)
  end

  def bought_date(id)
    Potepan::Checkout.find_by(order_id: id).created_at.strftime("%Y年 %m月 %d日")
  end

  def bought_products(id)
    Spree::Product.where(id: id)
  end

  def bought_price(products)
    @total_price = 0
    products.each do |product|
      @total_price += product.price
    end
    @total_price
  end
end
