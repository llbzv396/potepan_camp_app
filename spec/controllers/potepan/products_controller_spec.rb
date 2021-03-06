require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:taxon) { create(:taxon) }
  let(:property) { create(:property) }
  let(:product_property) { create(:product_property, property: property) }
  let(:product) do
    create(:product, product_properties: [product_property], taxons: [taxon])
  end

  describe "showアクションに関するテスト" do
    before do
      get :show, params: { slug_or_id: product }
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:ok)
    end

    it "適切なテンプレートが表示されているか" do
      expect(response).to render_template(:show)
    end

    describe "productに関するテスト" do
      it "@productは適切な情報を持つか" do
        expect(assigns(:product)).to eq product
      end

      it "@product_propertiesは適切な情報を持つか" do
        expect(assigns(:product_properties)).to eq product.product_properties
      end
    end

    describe "relted_productsに関するテスト" do
      let(:related_products) do
        create_list(:product, 4, product_properties: [product_property], taxons: [taxon])
      end

      it "@related_productsは適切な情報を持つか" do
        expect(assigns(:related_products)).to match_array(related_products)
      end

      describe "個数に関するテスト" do
        context "関連商品が3個の場合" do
          let!(:three_related_products) do
            create_list(:product, 3, product_properties: [product_property], taxons: [taxon])
          end

          it "@related_productsの数は3個か" do
            expect(assigns(:related_products).count).to eq 3
          end
        end

        context "関連商品が4個の場合" do
          let!(:four_related_products) do
            create_list(:product, 4, product_properties: [product_property], taxons: [taxon])
          end

          it "@related_productsの数は4個か" do
            expect(assigns(:related_products).count).to eq 4
          end
        end

        context "関連商品が5個の場合" do
          let!(:five_related_products) do
            create_list(:product, 5, product_properties: [product_property], taxons: [taxon])
          end

          it "@related_productsの数は4個に制限されているか" do
            expect(assigns(:related_products).count).to eq 4
          end
        end
      end
    end
  end
end
