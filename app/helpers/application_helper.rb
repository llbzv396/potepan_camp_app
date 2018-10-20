module ApplicationHelper
  def full_title(page_title = '')
    base_title = "BIGBAG Store"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def ec_page?
    params[:controller] == "potepan/categories"
  end

  def home_page?
    params[:controller] == "potepan/home"
  end

  def shop_page?
    params[:controller] == "potepan/products" || params[:controller] == "potepan/categories"
  end
end
