require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let!(:taxonomy) { create(:taxonomy) }
  let!(:root_taxon) { taxonomy.root }
  let!(:child_taxon) do
    create(:taxon, taxonomy: taxonomy,
                   parent_id: root_taxon.id,
                   name: "child_taxon")
  end
  let!(:product) do
    create(:product, price: 20.95,
                     description: "This is a product1",
                     taxons: [root_taxon, child_taxon])
  end

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
    expect(page).to have_content root_taxon.permalink
    expect(page).to have_content taxonomy.name
    expect(page).to have_content child_taxon.name
    expect(page).to have_content product.name
    expect(page).to have_content product.price
    expect(page).to have_current_path(potepan_category_path(root_taxon.id))
  end
end
