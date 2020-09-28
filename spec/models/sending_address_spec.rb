require 'rails_helper'

describe User do
  before do
    @sending_address = build(:sending_address)
  end

  describe '#create' do
    it "郵便番号がないと登録できないこと" do
      @sending_address.post_code = ""
      # factory_botを使用
      @sending_address.valid?
      expect(@sending_address.errors[:post_code]).to include("を入力してください")
      # 当アプリは日本語版へ変更しているためinclude("can't be blank")にするとエラーが生じる。
    end

    it "県名がないと登録できないこと" do
      @sending_address.prefecture_code = ""
      @sending_address.valid?
      expect(@sending_address.errors[:prefecture_code]).to include("を入力してください")
    end

    it "市町村がないと登録できないこと" do
      @sending_address.city = ""
      @sending_address.valid?
      expect(@sending_address.errors[:city]).to include("を入力してください")
    end

    it "番地がないと登録できないこと" do
      @sending_address.house_number = ""
      @sending_address.valid?
      expect(@sending_address.errors[:house_number]).to include("を入力してください")
    end

    it "名前がない場合は登録できないこと" do
      @sending_address.first_name = ""
      @sending_address.valid?
      expect(@sending_address.errors[:first_name]).to include("を入力してください")
    end

    it "名前(カナ)がない場合は登録できないこと" do
      @sending_address.first_name_kana = ""
      @sending_address.valid?
      expect(@sending_address.errors[:first_name_kana]).to include("を入力してください")
    end

    it "苗字がない場合は登録できないこと" do
      @sending_address.family_name = ""
      @sending_address.valid?
      expect(@sending_address.errors[:family_name]).to include("を入力してください")
    end

    it "苗字(カナ)がない場合は登録できないこと" do
      @sending_address.family_name_kana = ""
      @sending_address.valid?
      expect(@sending_address.errors[:family_name_kana]).to include("を入力してください")
    end

    it "user_idがないと登録できないこと" do
      @sending_address.user_id = ""
      @sending_address.valid?
      expect(@sending_address.errors[:user_id])
    end
  end
end
