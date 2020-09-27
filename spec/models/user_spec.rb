require 'rails_helper'

describe User do
  describe '#create' do
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      # factory_botを使用
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
      # 当アプリは日本語版へ変更しているためinclude("can't be blank")にするとエラーが生じる。
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it " passwordが6文字以下であれば登録できないこと " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it " passwordが7文字以上であれば登録できること " do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user).to be_valid
    end

    it "必須項目が埋められていれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
