require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "indexアクションに関するテスト" do
    let!(:lated_products) { create_list(:base_product, 5) }

    before do
      get :index
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      expect(response).to have_http_status "200"
    end

    it "新着商品が5個表示されていること" do
      expect(assigns(:lated_products).count).to eq(5)
    end

    it "indexアクション内の'@lated_products'と作成した'lated_products'が等しいか" do
      expect(assigns(:lated_products)).to match_array lated_products
    end
  end
end
