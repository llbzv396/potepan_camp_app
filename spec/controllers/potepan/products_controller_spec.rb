require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:property) { create(:property) }
  let(:product_property) { create(:product_property, property: property) }
  let(:product) { create(:product, product_properties: [product_property]) }

  describe "showアクションに関するテスト" do
    before do
      get :show, params: { id: product.id }
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:ok)
    end

    it "適切なテンプレートが表示されているか" do
      expect(response).to render_template(:show)
    end

    it "@productは適切な情報を持つか" do
      expect(assigns(:product)).to eq product
    end

    it "@product_propertiesは適切な情報を持つか" do
      expect(assigns(:product_properties)).to eq product.product_properties
    end
  end
end
