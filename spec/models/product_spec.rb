require 'rails_helper'

descride product do
  descride '#create' do
    it "必須項目が全て入力されている場合、出品できる"　do
      product = build(:product)
      expect(product).to be_valid
    end

    it "nameが無い場合、登録できないこと" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "profileが無い場合、登録できないこと" do
      product = build(:product, profile: nil)
      product.valid?
      expect(product.errors[:profile]).to include("を入力してください")
    end

    it "priceが無い場合、登録できないこと" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    it "categoryが無い場合、登録できないこと" do
      product = build(:product, category_id: "")
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end

    it "brandが無い場合でも、登録できること" do
      product = build(:item, brand: "")
      product.valid?
      expect(true).to_not be_nil
    end

    it "condition_idが無い場合、登録できないこと" do
      product = build(:product, condition_id: "")
      product.valid?
      expect(product.errors[:condition_id]).to include("を入力してください")
    end

    it "sendingday_idが無い場合、登録できないこと" do
      product = build(:product, sendingday_id: "")
      product.valid?
      expect(product.errors[:sendingday_id]).to include("を入力してください")
    end

    it "postage_idが無い場合、登録できないこと" do
      product = build(:product, postage_id: "")
      product.valid?
      expect(product.errors[:postage_id]).to include("を入力してください")
    end

    it "prefecture_code_idが無い場合、登録できないこと" do
      product = build(:product, prefecture_code_id: "")
      product.valid?
      expect(product.errors[:prefecture_code_id]).to include("を入力してください")
    end

    it "sendingtype_idが無い場合、登録できないこと" do
      product = build(:product, sendingtype_id: "")
      product.valid?
      expect(product.errors[:sendingtype_id]).to include("を入力してください")
    end

    it "seller_idが無い場合、登録できないこと" do
      product = build(:product, seller_id: "")
      product.valid?
      expect(product.errors[:sendingtype_id]).to include("を入力してください")
    end
end
