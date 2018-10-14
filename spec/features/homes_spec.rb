require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  let!(:root_taxon) { create(:taxon) }
  let!(:lated_product) do
    create(:product, name: 'lated_product',
                     available_on: 1.month.ago,
                     price: 20.24,
                     description: 'This is lated_product',
                     taxons: [root_taxon])
  end
  let!(:basis_product) do
    create_list(:product, 7,
                name: 'basis_product',
                available_on: 4.month.ago,
                price: 17.23)
  end
  let!(:old_product) do
    create(:product, name: 'old_product',
                     available_on: 1.years.ago,
                     price: 15.32)
  end

  before do
    visit potepan_path
  end

  scenario "ホームに表示されている内容を確認する" do
    expect(page).to have_content 'lated_product'
    expect(page).to have_content 20.24
    expect(page).to have_content 'basis_product'
    expect(page).to have_content 17.23
    expect(page).not_to have_content 'old_product'
    expect(page).not_to have_content 15.32
  end

  scenario "新着商品のリンクをクリックする" do
    click_on 'lated_product'
    expect(page).to have_current_path(potepan_product_path(lated_product))
    expect(page).to have_content 'lated_product'
    expect(page).to have_content 20.24
    expect(page).to have_content 'This is lated_product'
    expect(page).to have_content 'Return to list'
  end
end
