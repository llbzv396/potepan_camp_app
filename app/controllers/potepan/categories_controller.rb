class Potepan::CategoriesController < ApplicationController
  helper_method :option_value, :products_count_filtered_by_color, :products_count_filtered_by_size
  before_action :set_view_type, only: [:show]

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @options = Spree::OptionType.all.includes(:option_values)
    @numbers = [0, 1, 2, 3]
    @sort_list = ["新着順", "古い順", "値段が安い順", "値段が高い順"]
    @color = option_value(params[:color]).name if params[:color].present?
    @size =  option_value(params[:size]).name if params[:size].present?

    if filtered_by_size? && sorted?
      case params[:sort]
      when '0'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_size(option_value(params[:size]).name).
          including_images_prices.order("available_on DESC")
      when '1'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_size(option_value(params[:size]).name).
          including_images_prices.order("available_on ASC")
        @sort_list = @sort_list.values_at(1, 0, 2, 3)
        @numbers = @numbers.values_at(1, 0, 2, 3)
      when '2'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_size(option_value(params[:size]).name).
          including_images_prices.order("amount ASC")
        @sort_list = @sort_list.values_at(2, 0, 1, 3)
        @numbers = @numbers.values_at(2, 0, 1, 3)
      when '3'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_size(option_value(params[:size]).name).
          including_images_prices.order("amount DESC")
        @sort_list = @sort_list.values_at(3, 0, 1, 2)
        @numbers = @numbers.values_at(3, 0, 1, 2)
      end

    elsif filtered_by_size?
      @products = Spree::Product.filter_by_taxon(@taxon).
        filter_by_size(option_value(params[:size]).name).
        including_images_prices.order("available_on DESC")

    elsif filtered_by_color? && sorted?
      case params[:sort]
      when '0'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_color(option_value(params[:color]).name).
          including_images_prices.order("available_on DESC")
      when '1'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_color(option_value(params[:color]).name).
          including_images_prices.order("available_on ASC")
        @sort_list = @sort_list.values_at(1, 0, 2, 3)
        @numbers = @numbers.values_at(1, 0, 2, 3)
      when '2'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_color(option_value(params[:color]).name).
          including_images_prices.order("amount ASC")
        @sort_list = @sort_list.values_at(2, 0, 1, 3)
        @numbers = @numbers.values_at(2, 0, 1, 3)
      when '3'
        @products = Spree::Product.filter_by_taxon(@taxon).
          filter_by_color(option_value(params[:color]).name).
          including_images_prices.order("amount DESC")
        @sort_list = @sort_list.values_at(3, 0, 1, 2)
        @numbers = @numbers.values_at(3, 0, 1, 2)
      end

    elsif filtered_by_color?
      @products = Spree::Product.filter_by_taxon(@taxon).
        filter_by_color(option_value(params[:color]).name).
        including_images_prices.order("available_on DESC")

    elsif sorted?
      case params[:sort]
      when '0'
        @products = Spree::Product.filter_by_taxon(@taxon).
          including_images_prices.order("available_on DESC")
      when '1'
        @products = Spree::Product.filter_by_taxon(@taxon).
          including_images_prices.order("available_on ASC")
        @sort_list = @sort_list.values_at(1, 0, 2, 3)
        @numbers = @numbers.values_at(1, 0, 2, 3)
      when '2'
        @products = Spree::Product.filter_by_taxon(@taxon).
          including_images_prices.order("amount ASC")
        @sort_list = @sort_list.values_at(2, 0, 1, 3)
        @numbers = @numbers.values_at(2, 0, 1, 3)
      when '3'
        @products = Spree::Product.filter_by_taxon(@taxon).
          including_images_prices.order("amount DESC")
        @sort_list = @sort_list.values_at(3, 0, 1, 2)
        @numbers = @numbers.values_at(3, 0, 1, 2)
      end

    else
      @products = Spree::Product.filter_by_taxon(@taxon).
        including_images_prices.order("available_on DESC")
    end
  end

  private

  def option_value(value)
    Spree::OptionValue.find(value)
  end

  def filtered_by_color?
    params[:color].present?
  end

  def filtered_by_size?
    params[:size].present?
  end

  def sorted?
    params[:sort].present?
  end

  def products_count_filtered_by_color(value)
    Spree::Product.filter_by_taxon(@taxon).filter_by_color(value).ids.uniq.count
  end

  def products_count_filtered_by_size(value)
    Spree::Product.filter_by_taxon(@taxon).filter_by_size(value).ids.uniq.count
  end

  def set_view_type
    if params[:format] == 'list'
      session[:format] = 'list'
    elsif params[:format] == 'grid'
      session[:format] = 'grid'
    end
  end
end
