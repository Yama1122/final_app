require 'rails_helper'
descride product do
  descride '#create' do
    it "必須項目が全て入力されている場合出品できる"　do
      product = build(:product)
      expect(product).to be_valid
    end
    it "nameが無い場合登録できないこと" do
      product = build(:product, name: nil )
      product.valid?
      expect(product.errors[:name]).to include("入力してください")
    end
    it "profileが無い場合登録できないこと" do
      product = build(:product, profile: nil)
      product.valid?
      expect(product.errors[:profile]).to include("入力してください")
    end
  end

end
end
