require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:product) { create(:base_product) }

  before do
    get :show, params: { id: product.id }
  end

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      expect(response).to have_http_status "200"
    end

    it "showアクション内の'@product'と作成した'product'が等しいか" do
      expect(assigns(:product)).to eq product
    end
  end
end
