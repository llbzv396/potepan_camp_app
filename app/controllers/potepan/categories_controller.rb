class Potepan::CategoriesController < ApplicationController
  helper_method :option_value, :products_count_filtered_by_color
  before_action :set_view_type, only: [:show]

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @options = Spree::OptionType.all.includes(:option_values)

    if filtered_by_color?
      @products = Spree::Product.
        in_taxon(@taxon).
        filter_by_color(option_value(params[:color]).name, option_type(params[:type]).id).
        including_images_prices
    else
      @products = Spree::Product.including_images_prices.in_taxon(@taxon)
    end
  end

  private

  def option_value(value)
    Spree::OptionValue.find(value)
  end

  def option_type(type)
    Spree::OptionType.find(type)
  end

  def products_count_filtered_by_color(value, type)
    Spree::Product.
      in_taxon(@taxon).
      filter_by_color(value, type).ids.uniq.count
  end

  def filtered_by_color?
    params[:color].present?
  end

  def set_view_type
    if params[:format] == 'list'
      session[:format] = 'list'
    elsif params[:format] == 'grid'
      session[:format] = 'grid'
    end
  end
end
