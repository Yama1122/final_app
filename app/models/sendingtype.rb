class Sendingtype < ActiveHash::Base
  self.data = [
      {id: 0, name: '選択してください'},
      {id: 1, name: '未定'}, {id: 2, name: 'らくらくメルカリ便'}, {id: 3, name: 'ゆうゆうメルカリ便'},
      {id: 4, name: 'ゆうメール'}, {id: 5, name: 'レターパック'}, {id: 6, name: '普通郵便（定型、定型'}, 
      {id: 7, name: 'クロネコヤマト'}, {id: 8, name: 'ゆうパック'}, {id: 9, name: 'クリックポスト'}, 
      {id: 10, name: 'ゆうパケット'},  
  ]
end