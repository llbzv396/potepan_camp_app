require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:base_product, taxons: [taxon]) }
  let(:related_products) { create_list(:product, 4, taxons: [taxon]) }

  before do
    get :show, params: { id: product.id }
  end

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:ok)
    end

    describe "single_product.html.erbに関するテスト" do
      it "showアクション内の'@product'と作成した'product'が等しいか" do
        expect(assigns(:product)).to eq product
      end
    end

    describe "related_product.html.erbに関するテスト" do
      it "showアクション内の'@related_products'と作成した'related_products'が等しいか" do
        expect(assigns(:related_products)).to eq related_products
      end
    end
  end
end
