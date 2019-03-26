Spree::Product.class_eval do
  scope :related_products, ->(product) {
    joins(:taxons).where(spree_taxons: { id: product.taxons.ids }).
      where.not(id: product.id).distinct
  }
  scope :including_images_prices, -> {
    includes(master: [:images, :default_price])
  }
  scope :filter_by_color, ->(value, type) {
    joins(variants_including_master: :option_values).
      where("spree_option_values.name = ? AND spree_option_values.option_type_id = ?", value, type)
  }
  scope :filter_by_taxon, ->(taxon) {
    includes(:classifications).
      where("spree_products_taxons.taxon_id" => taxon.self_and_descendants.pluck(:id))
  }
end
