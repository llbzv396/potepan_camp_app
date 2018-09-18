require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  let(:taxon) { create(:taxon) }
  let(:products) { create_list(:product, 10, taxons: [taxon]) }

  before do
    get :show, params: { id: taxon.id }
  end

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:ok)
    end

    it "showアクション内の'@taxons'と作成した'taxon'が等しいか" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "showアクション内の'@products'と作成した'products'が等しいか" do
      expect(assigns(:products)).to eq products
    end
  end
end
