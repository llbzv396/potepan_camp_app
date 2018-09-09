require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  let!(:root_taxon) { create(:taxon) }
  let!(:lated_product) do
    create(:base_product, name: "lated_product",
                          available_on: 1.month.ago, taxons: [root_taxon])
  end
  let!(:products) { create_list(:base_product, 4, available_on: 4.month.ago) }
  let!(:old_product) { create(:base_product, price: 15.00) }

  scenario "home/index に表示されている内容を確認する" do
    visit potepan_path
    expect(page).to have_content lated_product.name
    expect(page).to have_content lated_product.price
    expect(page).not_to have_content old_product.name
    expect(page).not_to have_content old_product.price
  end

  scenario "home/index に表示されている新着商品のリンクをクリックする" do
    visit potepan_path
    click_on "#{lated_product.name}"
    expect(page).to have_current_path(potepan_product_path(lated_product))
    expect(page).to have_content lated_product.name
    expect(page).to have_content lated_product.price
    expect(page).to have_content lated_product.description
    expect(page).to have_content "Return to list"
  end
end
