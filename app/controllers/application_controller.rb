class ApplicationController < ActionController::Base
  include SessionsHelper
  include ProductsHelper
  protect_from_forgery with: :exception
  before_action :get_products_data
end
