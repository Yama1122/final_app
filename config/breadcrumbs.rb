# ルート
crumb :root do
  link "トップページ", root_path
end

# ユーザーマイページ
crumb :user do
  link "マイページ",user_path(current_user.id)
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


