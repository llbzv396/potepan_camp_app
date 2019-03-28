class ApplicationController < ActionController::Base
  include SessionsHelper
  include ProductsHelper
  protect_from_forgery with: :exception
  before_action :get_products_data
  before_action :get_order_id

  def get_order_id
    if logged_in?
      order = Potepan::Order.find_by(user_id: current_user.id, state: 1)
      if order
        @order_id = order.id
      else
        order = Potepan::Order.new(user_id: current_user.id, state: 1)
        order.save
        @order_id = order.id
      end
    end
  end
end
