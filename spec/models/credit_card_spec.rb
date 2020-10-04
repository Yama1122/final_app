require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    it "user_id, customer_id, card_idが存在すれば登録できる" do
      user = build(:user)
      card = build(:credit_card)
      expect(card).to be_valid
    end
    it "user_idが無い場合は登録できない" do
      card = build(:credit_card, user_id: nil)
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end
    it "customer_idが無い場合は登録できない" do
      card = build(:credit_card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    it "card_idが無い場合は登録できない" do
      card = build(:credit_card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end
