class Sendingtype < ActiveHash::Base
  self.data = [
      # {id: 0, name: '選択してください'}を削除しました,
      {id: 0, name: '未定'}, {id: 1, name: 'らくらくフリマ便'}, {id: 2, name: 'ゆうゆうフリマ便'},
      {id: 3, name: 'ゆうメール'}, {id: 4, name: 'レターパック'}, {id: 5, name: '普通郵便（定型、定型'}, 
      {id: 6, name: 'クロネコヤマト'}, {id: 7, name: 'ゆうパック'}, {id: 8, name: 'クリックポスト'}, 
      {id: 9, name: 'ゆうパケット'},  
  ]
end