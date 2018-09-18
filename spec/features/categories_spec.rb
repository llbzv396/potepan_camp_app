require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let(:taxonomy) { create(:taxonomy) }
  let(:root_taxon) do
    create(:taxon, taxonomy_id: taxonomy.id,
                   id: 1,
                   parent_id: nil)
  end
  let!(:child_taxon1) do
    create(:taxon, taxonomy_id: taxonomy.id,
                   parent_id: root_taxon.id,
                   name: "child_taxon1")
  end
  let!(:child_taxon2) do
    create(:taxon, taxonomy_id: taxonomy.id,
                   parent_id: root_taxon.id,
                   name: "child_taxon2")
  end
  let!(:product1) { create(:base_product, taxons: [root_taxon, child_taxon1]) }
  let!(:product2) { create(:base_product, taxons: [root_taxon, child_taxon2]) }

  before do
    visit potepan_category_path(root_taxon.id)
  end

  scenario "categories/show に表示されている商品一覧を確認する" do
    expect(page).to have_content root_taxon.name
    expect(page).to have_content taxonomy.name
    expect(page).to have_content child_taxon1.name
    expect(page).to have_content child_taxon2.name
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
  end

  scenario "categories/show のサイドバーのリンクを確認する" do
    click_on "#{child_taxon1.name}"
    expect(page).to have_content root_taxon.permalink
    expect(page).to have_content taxonomy.name
    expect(page).to have_content child_taxon1.name
    expect(page).to have_content child_taxon2.name
    expect(page).to have_content product1.name
    expect(page).not_to have_content product2.name
    expect(page).to have_current_path(potepan_category_path(child_taxon1.id))
  end

  scenario "categories/show に表示されている商品ページのリンクをクリックする" do
    click_on "#{product1.name}"
    expect(page).to have_content product1.name
    expect(page).to have_content product1.price
    expect(page).to have_content product1.description
    expect(page).to have_content "Return to list"
    expect(page).to have_current_path(potepan_product_path(product1))
  end
end
