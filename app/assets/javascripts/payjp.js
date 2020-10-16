// 新規クレジットカード登録処理
$(document).on('turbolinks:load',function(){
  $("#charge-form").on("submit",function(e){
    // 送信をキャンセルしてPAY.JPの登録に必要な処理を行う
    e.preventDefault();
    // 公開鍵のセット(秘密鍵と違い直接記述してOK)
    Payjp.setPublicKey("pk_test_b2651e20c2423c3197a21001");
    // フォーム入力情報の取得
    let card = {
      number: document.getElementById("card_number").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value,
      cvc: document.getElementById("cvc").value
    };
    // 入力漏れの防止
    if (card.number == "" || card.cvc == ""){
      alert("入力もれがあります。");
    }else{
      // 上でセットした情報をトークンという暗号に変換
      Payjp.createToken(card,function(status,response){
        // 正しくトークンが作成された場合
        if(status === 200 ){
          // セキュリティの観点からフォームに入力した値を削除し自サーバに送信しない
          $("#card_number").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          $("#cvc").removeAttr("name");
          // トークン情報を保存するための処理
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          );
          // フォーム情報を送信
          $('#charge-form').get(0).submit();
        }else{
          alert("カード情報が正しくありません");
        }
      });
    }
  });
});