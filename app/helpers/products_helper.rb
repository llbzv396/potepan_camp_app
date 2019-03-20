module ProductsHelper
  def get_products_data
    @taxons = Spree::Taxon.where.not(parent_id: nil).where(taxonomy_id: 1)
    @brands = Spree::Taxon.where.not(parent_id: nil).where(taxonomy_id: 2)
  end
end
