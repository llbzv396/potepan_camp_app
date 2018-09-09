require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  let(:taxon) { create(:taxon) }
  let(:products) do
    create_list(:product, 10) do |product|
      product.taxons << taxon
    end
  end

  before do
    get :show, params: { id: taxon.id }
  end

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      expect(response). to have_http_status "200"
    end

    it "showアクション内の'@taxons'と作成した'taxon'が等しいか" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "showアクション内の'@products'と作成した'products'が等しいか" do
      expect(assigns(:products)).to eq products
    end
  end
end
