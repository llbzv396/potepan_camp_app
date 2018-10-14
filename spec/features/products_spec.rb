require 'rails_helper'

RSpec.feature 'Products', type: :feature do
  let!(:taxonomy) { create(:taxonomy) }
  let!(:root_taxon) { taxonomy.root }
  let!(:child_taxon) do
    create(:taxon, taxonomy: taxonomy,
                   parent_id: root_taxon.id,
                   name: 'child_taxon')
  end
  let(:basis_product) do
    create(:product, name: 'basis_product',
                     price: 20.75,
                     description: 'This is a basis_product',
                     taxons: [root_taxon, child_taxon])
  end
  let!(:related_product1) do
    create(:product, name: 'related_product1',
                     price: 15.43,
                     description: 'This is a related_product1',
                     taxons: [root_taxon, child_taxon])
  end
  let!(:related_product2) do
    create(:product, name: 'related_product2',
                     price: 10.81,
                     taxons: [root_taxon, child_taxon])
  end
  let!(:non_related_product) do
    create(:product, name: 'non_related_product',
                     price: 3.86,
                     taxons: [])
  end

  before do
    visit potepan_product_path(basis_product)
  end

  scenario '選択した商品の情報が表示されているか' do
    expect(page).to have_content 'basis_product'
    expect(page).to have_content 20.75
    expect(page).to have_content 'This is a basis_product'
    expect(page).to have_content 'Return to list'
  end

  scenario '選択した商品に関連する商品だけが表示されているか' do
    expect(page).to have_content 'related_product1'
    expect(page).to have_content 15.43
    expect(page).to have_content 'related_product2'
    expect(page).to have_content 10.81
    expect(page).not_to have_content 'non_related_product'
    expect(page).not_to have_content 3.86
  end

  scenario '関連する商品名をクリックしたらその商品ページへ遷移するか' do
    click_on 'related_product1'
    expect(page).to have_content 'related_product1'
    expect(page).to have_content 15.43
    expect(page).to have_content 'This is a related_product1'
    expect(page).to have_current_path(potepan_product_path(related_product1))
  end

  scenario 'return to listをクリックしたらカテゴリ一覧ページへ遷移するか' do
    click_on 'Return to list'
    expect(page).to have_content 'basis_product'
    expect(page).to have_content 20.75
    expect(page).to have_content 'related_product1'
    expect(page).to have_content 15.43
    expect(page).to have_content 'related_product2'
    expect(page).to have_content 10.81
    expect(page).to have_current_path(potepan_category_path(root_taxon.id))
  end
end
