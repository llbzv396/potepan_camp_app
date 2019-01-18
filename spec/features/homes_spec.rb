require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  let!(:taxon) { create(:taxon) }
  let!(:txon_of_shirt) { create(:taxon, name: 'Shirts') }
  let!(:txon_of_bags) { create(:taxon, name: 'Bags') }
  let!(:txon_of_mugs) { create(:taxon, name: 'Mugs') }
  let!(:lated_product) do
    create(:product, name: 'lated_product',
                     available_on: 1.month.ago,
                     price: 20.24,
                     description: 'This is lated_product',
                     taxons: [taxon])
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

  scenario "新着商品のみが表示されているか" do
    expect(page).to have_content 'lated_product'
    expect(page).to have_content 20.24
    expect(page).to have_content 'basis_product'
    expect(page).to have_content 17.23
    expect(page).not_to have_content 'old_product'
    expect(page).not_to have_content 15.32
  end

  scenario "新着商品のリンクをクリックしたら、商品ページへ遷移すること" do
    click_on 'lated_product'
    expect(page).to have_current_path(potepan_product_path(lated_product))
    expect(page).to have_content 'lated_product'
    expect(page).to have_content 20.24
    expect(page).to have_content 'This is lated_product'
  end
end
