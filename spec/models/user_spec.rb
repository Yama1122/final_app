require 'rails_helper'

describe User do
  before do
    @user = build(:user)
  end
  
  describe '#create' do
    it "nicknameがない場合は登録できないこと" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors[:nickname]).to include("を入力してください")
      # 当アプリは日本語版へ変更しているためinclude("can't be blank")にするとエラーが生じる。
    end

    it "emailがない場合は登録できないこと" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      @user.password = ""
      @user.valid?
      expect(@user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it " passwordが6文字以下であれば登録できないこと " do
      @user.password = "000000"
      @user.password_confirmation = "000000"
      @user.valid?
      expect(@user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it " passwordが7文字以上であれば登録できること " do
      @user.password = "0000000"
      @user.password_confirmation = "0000000"
      @user.valid?
      expect(@user).to be_valid
    end

    it "名前がない場合は登録できないこと" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors[:first_name]).to include("を入力してください")
    end

    it "名前(カナ)がない場合は登録できないこと" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "苗字がない場合は登録できないこと" do
      @user.family_name = ""
      @user.valid?
      expect(@user.errors[:family_name]).to include("を入力してください")
    end

    it "苗字(カナ)がない場合は登録できないこと" do
      @user.family_name_kana = ""
      @user.valid?
      expect(@user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "生年月日がない場合は登録できないこと" do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors[:birth_date]).to include("を入力してください")
    end

    it "必須項目が埋められていれば登録できること" do
      expect(@user).to be_valid
    end
  end
end
