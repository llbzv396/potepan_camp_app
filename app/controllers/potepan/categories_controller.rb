class Potepan::CategoriesController < ApplicationController
  helper_method :option_value, :products_count_filtered_by_color

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @options = Spree::OptionType.all.includes(:option_values)
    if params[:color].present?
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

end
