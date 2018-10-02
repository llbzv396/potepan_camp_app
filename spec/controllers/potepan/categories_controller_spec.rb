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

    it "適切なテンプレートが表示されているか" do
      expect(response).to render_template(:show)
    end

    it "@taxonsは適切な情報を持つか" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "@productsは適切な情報を持つか" do
      expect(assigns(:products)).to eq products
    end
  end
end
