require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:root_taxon) { create(:taxon) }
  let(:child_taxon) { create(:taxon, parent_id: root_taxon.id) }
  let(:product) { create(:base_product, taxons: [root_taxon, child_taxon]) }

  before do
    visit potepan_product_path(product)
  end

  scenario "商品に関する情報が表示されているか" do
    expect(page).to have_content product.name
    expect(page).to have_content product.price
    expect(page).to have_content product.description
    expect(page).to have_content "Return to list"
  end

  scenario "return to listをクリックする" do    
    click_on "Return to list"
    expect(page).to have_content root_taxon.name
    expect(page).to have_content taxonomy.name
    expect(page).to have_content child_taxon.name
    expect(page).to have_content product.name
    expect(page).to have_current_path(potepan_category_path(root_taxon.id))
  end
end
