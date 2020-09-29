FactoryBot.define do
  factory :user do
    id{"1"}
    email{"test@user"}
    encrypted_password{"XXXXXX"}
    created_at{"2020-05-22 00:00:00"}
    updated_at{"2020-05-22 00:00:00"}
    nickname{"test"}
    first_name{"テスト"}
    family_name{"テスト"}
    first_name_kana{"テスト"}
    family_name_kana{"テスト"}
    birth_date{"2020-08-16"}
    introduction{"テスト"}
  end
end
