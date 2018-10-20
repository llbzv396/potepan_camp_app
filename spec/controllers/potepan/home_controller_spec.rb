require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "indexアクションに関するテスト" do
    before do
      get :index
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:ok)
    end

    it "適切なテンプレートが表示されているか" do
      expect(response).to render_template(:index)
    end

    describe "新着商品に関するテスト" do
      let(:product1) { create(:product, available_on: 1.month.ago) }
      let(:product2) { create(:product, available_on: 2.month.ago) }
      let(:product3) { create(:product, available_on: 3.month.ago) }
      let(:product4) { create(:product, available_on: 4.month.ago) }
      let(:product5) { create(:product, available_on: 5.month.ago) }
      let(:product6) { create(:product, available_on: 6.month.ago) }
      let(:product7) { create(:product, available_on: 7.month.ago) }
      let(:product8) { create(:product, available_on: 8.month.ago) }
      let(:product9) { create(:product, available_on: 9.month.ago) }
      let(:lated_products) { [product1, product2, product3, product4] }

      it "@lated_productsは適切な情報を持つか" do
        expect(assigns(:lated_products)).to eq lated_products
      end

      describe "新着商品の個数に関するテスト" do
        context "7個の場合" do
          let!(:seventh_lated_products) do
            [product1, product2, product3, product4, product5, product6, product7]
          end

          it "@lated_productsの数は7個か" do
            expect(assigns(:lated_products).count).to eq 7
          end
        end

        context "8個の場合" do
          let!(:eighth_lated_products) do
            [product1, product2, product3, product4, product5, product6, product7, product8]
          end

          it "@lated_productsの数は8個か" do
            expect(assigns(:lated_products).count).to eq 8
          end
        end

        context "9個の場合" do
          let!(:ninth_lated_products) do
            [
              product1, product2, product3, product4,
              product5, product6, product7, product8, product9,
            ]
          end

          it "@lated_productsの数は8個に制限されているか" do
            expect(assigns(:lated_products).count).to eq 8
          end
        end
      end
    end
  end
end
