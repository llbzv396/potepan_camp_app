require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:taxonomy) { create(:taxonomy, taxons: [root_taxon]) }
  let!(:root_taxon) { create(:taxon, name: "root_taxon") }
  let!(:child_taxon) do
    create(:taxon, taxonomy_id: taxonomy.id,
                   parent_id: root_taxon.id,
                   name: "child_taxon")
  end
  let(:basis_product) do
    create(:product, name: "basis_product",
                     price: 20.75,
                     taxons: [root_taxon, child_taxon])
  end
  let!(:related_product1) do
    create(:product, name: "related_product1",
                     price: 15.43,
                     taxons: [root_taxon, child_taxon])
  end
  let!(:related_product2) do
    create(:product, name: "related_product2",
                     price: 10.81,
                     taxons: [root_taxon, child_taxon])
  end
  let!(:non_related_product) do
    create(:product, name: "non_related_product",
                     price: 3.86,
                     taxons: [])
  end

  before do
    visit potepan_product_path(basis_product)
  end

  scenario "選択した商品の情報が表示されているか" do
    expect(page).to have_content basis_product.name
    expect(page).to have_content basis_product.price
    expect(page).to have_content basis_product.description
    expect(page).to have_content "Return to list"
  end

  scenario "選択した商品に関連する商品だけが表示されているか" do
    expect(page).to have_content related_product1.name
    expect(page).to have_content related_product1.price
    expect(page).to have_content related_product2.name
    expect(page).to have_content related_product2.price
    expect(page).not_to have_content non_related_product.name
    expect(page).not_to have_content non_related_product.price
    expect(page).to have_content "Return to list"
  end

  scenario "return to listをクリックする" do
    click_on "Return to list"
    expect(page).to have_content root_taxon.permalink
    expect(page).to have_content taxonomy.name
    expect(page).to have_content child_taxon.name
    expect(page).to have_content basis_product.name
    expect(page).to have_content basis_product.price
    expect(page).to have_content related_product1.name
    expect(page).to have_content related_product1.price
    expect(page).to have_content related_product2.name
    expect(page).to have_content related_product2.price
    expect(page).to have_current_path(potepan_category_path(root_taxon.id))
  end
end
