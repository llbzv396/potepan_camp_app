Spree::Product.class_eval do
  scope :related_products, ->(product) {
    joins(:taxons).where(spree_taxons: { id: product.taxons.ids }).
      where.not(id: product.id).distinct
  }
  scope :including_images_prices, -> { includes(master: [:images, :default_price]) }
end
