require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: 'taxonomy') }
  let!(:root_taxon) { taxonomy.root }
  let!(:color_value1) { create(:option_value, name: "Red", presentation: "Red") }
  let!(:color_value2) { create(:option_value, name: "Blue", presentation: "Blue") }
  let!(:color_option) do
    create(:option_type, option_values: [],
                         id: 2,
                         name: "Color",
                         presentation: "Color")
  end
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
                     taxons: [child_taxon1])
  end
  let!(:product2) do
    create(:product, name: 'Second_Product',
                     price: 15.34,
                     taxons: [child_taxon2])
  end

  before do
    visit potepan_category_path(root_taxon.id)
  end

  scenario 'root_taxonに属する商品一覧が表示されているか' do
    expect(page).to have_content 'taxonomy'
    expect(page).to have_content root_taxon.name
    expect(page).to have_content 'child_taxon1'
    expect(page).to have_content 'child_taxon2'
    expect(page).to have_content 'First_Product'
    expect(page).to have_content (20.95 * 110).to_i
    expect(page).to have_content 'Second_Product'
    expect(page).to have_content (15.34 * 110).to_i
  end

  scenario '選択したカテゴリーで絞り込みができるか' do
    click_on 'child_taxon1'
    expect(page).to have_content child_taxon1.name
    expect(page).to have_content 'First_Product'
    expect(page).to have_content (20.95 * 110).to_i
    expect(page).not_to have_content 'Second_Product'
    expect(page).not_to have_content (15.34 * 110).to_i
    expect(page).to have_current_path(potepan_category_path(child_taxon1.id))
  end

  scenario '商品名をクリックしたらその商品ページへ遷移するか' do
    click_on 'First_Product'
    expect(page).to have_content 'First_Product'
    expect(page).to have_content (20.95 * 110).to_i
    expect(page).to have_content 'This is a product1'
    expect(page).to have_content '商品一覧に戻る'
    expect(page).to have_current_path(potepan_product_path(product1))
  end

  # scenario "色で絞り込む" do
  #  click_on "#{color_value1.name}"
  #  save_and_open_page
  # 色をクリック
  # 商品の表示が適正か確認
  # 今のパスを確認
  # end

  # scenario "カテゴリで絞り込んだ商品を更に色で絞り込む" do
  # 色をクリック
  # 商品の表示が適正か確認
  # 今のパスを確認
  # end

  # scenario "色で絞り込む" do
  # 色で絞り込む
  # 商品の表示が適正か確認
  # 今のパスを確認
  # end

  # scenario "カテゴリで絞り込んだ商品を更に色で絞り込む" do
  # カテゴリで絞り込む
  # 色で絞り込む
  # 商品の表示が適正か確認
  # 今のパスを確認
  # end
end
