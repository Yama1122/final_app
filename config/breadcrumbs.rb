# ルート
crumb :root do
  link "トップページ", root_path
end

# ユーザーマイページ
crumb :user do
  link "マイページ",user_path(current_user.id)
end

# ログアウトページ
crumb :logout do
  link "ログアウト",logout_user_path(current_user.id)
  parent :user
end

# クレジット新規登録
crumb :credit_delete do
  link "クレジットカード情報削除",delete_credit_cards_path
  parent :user
end

# クレジット新規登録
crumb :credit_new do
  link "クレジットカード新規登録",new_credit_card_path
  parent :user
end

# クレジット一覧
crumb :credit_index do
  link "登録クレジットカード情報",credit_card_path(params[:id])
  parent :user
end

# 商品詳細ページ
crumb :product do |product|
  product = Product.find(params[:id])
  category = Category.find(product.category_id)
  link "#{product.name}",product_path(product)
  if category.has_children?
    parent :product_child_category
  else
    parent :product_grandchild_category
  end
end

# 商品詳細親カテゴリ
crumb :product_parent_category do |product|
  product = Product.find(params[:id])
  category = Category.find(product.category_id).root
  link "#{category.name}",category_path(category)
  parent :category_index
end

# 商品詳細子カテゴリ
crumb :product_child_category do |product|
  product = Product.find(params[:id])
  category = Category.find(product.category_id)
  # 表示ページが子カテゴリ一（子供がいる）場合
  if category.has_children?
    link "#{category.name}", category_path(category)
    parent :product_parent_category
    # 表示ページが孫カテゴリーの場合
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :product_parent_category
  end
end

# 商品詳細孫カテゴリ
crumb :product_grandchild_category do |product|
  product = Product.find(params[:id])
  category = Category.find(product.category_id)
  link "#{category.name}", category_path(category)
  parent :product_child_category
end



# カテゴリ一覧
crumb :category_index do
  link "カテゴリー一覧", categories_path
end

# 親カテゴリ
crumb :parent_category do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}",category_path(category)
  parent :category_index
end

# 子カテゴリ
crumb :child_category do |category|
  category = Category.find(params[:id])
  # 表示ページが子カテゴリ一（子供がいる）場合
  if category.has_children?
    link "#{category.name}", category_path(category)
    parent :parent_category
    # 表示ページが孫カテゴリーの場合
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :parent_category
  end
end

# 孫カテゴリ
crumb :grandchild_category do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :child_category
end


