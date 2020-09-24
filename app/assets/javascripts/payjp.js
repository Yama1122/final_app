$(function(){
  $("#charge-form").on("submit",function(e){
    // 送信をキャンセルしてPAY.JPの登録に必要な処理を行う
    e.preventDefault();
    // 公開鍵のセット(秘密鍵と違い直接記述してOK)
    Payjp.setPublicKey("pk_test_b2651e20c2423c3197a21001");
    let card = {
      number: document.getElementById("card_number").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value,
      cvc: document.getElementById("cvc").value
    };
    if (card.number == "" || card.cvc == ""){
      alert("入力もれがあります。");
    }else{
      Payjp.createToken(card,function(status,response){
        // 正しくトークンが作成された場合
        if(status === 200 ){
          // セキュリティの観点からフォームに入力した値を削除
          $("#card_number").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          );
          $('#charge-form').get(0).submit();
          alert("登録に成功しました");
        }else{
          alert("カード情報が正しくありません");
        }
      });
    }
  });
});