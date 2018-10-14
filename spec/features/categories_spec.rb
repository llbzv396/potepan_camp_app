require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: 'taxonomy') }
  let!(:root_taxon) { taxonomy.root }
  let!(:child_taxon1) do
    create(:taxon, taxonomy: taxonomy,
                   parent_id: root_taxon.id,
                   name: 'child_taxon1')
  end
  let!(:child_taxon2) do
    create(:taxon, taxonomy: taxonomy,
                   parent_id: root_taxon.id,
                   name: 'child_taxon2')
  end
  let!(:product1) do
    create(:product, name: 'First_Product',
                     price: 20.95,
                     description: 'This is a product1',
                     taxons: [root_taxon, child_taxon1])
  end
  let!(:product2) do
    create(:product, name: 'Second_Product',
                     price: 15.34,
                     taxons: [root_taxon, child_taxon2])
  end

  before do
    visit potepan_category_path(root_taxon.id)
  end

  scenario 'root_taxonに属する商品一覧が表示されているか' do
    expect(page).to have_content 'taxonomy'
    expect(page).to have_content root_taxon.permalink
    expect(page).to have_content 'child_taxon1'
    expect(page).to have_content 'child_taxon2'
    expect(page).to have_content 'First_Product'
    expect(page).to have_content 20.95
    expect(page).to have_content 'Second_Product'
    expect(page).to have_content 15.34
  end

  scenario '選択したカテゴリーで絞り込みができるか' do
    click_on 'child_taxon1'
    expect(page).to have_content child_taxon1.permalink
    expect(page).to have_content 'First_Product'
    expect(page).to have_content 20.95
    expect(page).not_to have_content 'Second_Product'
    expect(page).not_to have_content 15.34
    expect(page).to have_current_path(potepan_category_path(child_taxon1.id))
  end

  scenario '商品名をクリックしたらその商品ページへ遷移するか' do
    click_on 'First_Product'
    expect(page).to have_content 'First_Product'
    expect(page).to have_content 20.95
    expect(page).to have_content 'This is a product1'
    expect(page).to have_content 'Return to list'
    expect(page).to have_current_path(potepan_product_path(product1))
  end
end
