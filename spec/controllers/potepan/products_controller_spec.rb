require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:product) { create(:base_product) }

  describe "indexアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      get :index
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      get :index
      expect(response).to have_http_status "200"
    end

    it "新着商品が表示されていること" do
    end
  end

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      get :show, params: { id: product.id }
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status "200"
    end

    it "showアクション内の'@product'と作成した'product'が等しいか " do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end
  end
end
