class Postage < ActiveHash::Base
  self.data = [
      # {id: 0, name: '選択してください'}を削除しました
      {id: 0, name: '送料込み（出品者負担）'}, {id: 1, name: '送料別（購入者負担）'},  
  ]
end