$(document).on('turbolinks:load',function(){

  // 削除コメント表示用
  function pleDelete(index){
    let html =
    `
      <div class="commentBox__list__other-contents__content__comment__top">
        <p class="comment_delete">出品者によりこのコメントは削除されました。</p>
      </div>
    `
    return html;
  };

  // 自分のコメントを削除
  $('.me_pre_delete').on('click',function(e){
    e.preventDefault();
    // カスタムデータの取得
    let index = $(this).data("index");
    // 削除ボタンの削除
    $(this).remove();
    // コメントを置き換え
    content = $(`.commentBox__list__contents__other-content[data-index=${index}]`).find(".commentBox__list__contents__other-content__comment");
    content.empty();
    content.append(pleDelete(index));
    url = '/comments/' + index;
    $.ajax({
      url: url,
      type: 'PATCH',
    })
  });

  // 他のユーザーのコメントを削除
  $('.other_pre_delete').on('click',function(e){
    e.preventDefault();
    // カスタムデータの取得
    let index = $(this).data("index");
    // 削除ボタンの削除
    $(this).remove();
    
    // コメントを置き換え
    content = $(`.commentBox__list__contents__content[data-index=${index}]`).find(".commentBox__list__contents__content__comment");
    content.empty();
    content.append(pleDelete(index));
    $(`.commentBox__list__contents__content[data-index=${index}]`).find(".commentBox__list__contents__content__btns").append(pleDeleteBtn(index));
    url = '/comments/' + index;
    $.ajax({
      url: url,
      type: 'PATCH',
    })
  });

  // 新規コメントの表示用
  function new_comment(comment_data){
    let HTML_top =
    `
    <div class="commentBox__list__contents__other-content" data-index=${comment_data.id}>
    `

    let HTML_content_time =
    `
      <div class="commentBox__list__contents__other-content__comment">
        <div class=".commentBox__list__contents__other-content__comment__top">
          <p>
            ${comment_data.comment}
          </p>
        </div>
        <div class="commentBox__list__contents__other-content__comment__bottom">
          <p>
            ${comment_data.created_at}
          </p>
        </div>
      </div>
    ` 
  
    let HTML_deleteBtn =
    `
    <div class ="commentBox__list__contents__other-content__btns">
      <div class ="commentBox__list__contents__other-content__btns__deletebtn me_pre_delete" data-index=${comment_data.id}>
        <p>削除</p>
      </div>
    </div>
    ` 

    let HTML_bottom = 
    `
    </div>
    `

    // ボタンの有無を分岐
    if (comment_data.product_seller.id == comment_data.user_id){
      // if文内のletは使えない(?)
      var html = HTML_top + HTML_content_time + HTML_deleteBtn + HTML_bottom
    }else{
      var html = HTML_top + HTML_content_time + HTML_bottom
    };

    return html;
  };

  
  
  // コメント作成のAjax通信
  $("#comment_form").on("submit",function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr("action");
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType:'json',
      processData: false,
      contentType: false
    })
    .done(function(comment_data){
      let html = new_comment(comment_data);
      $(".commentBox__list__contents").append(html);
      $(".commentBox__text").val("");
      $(".commentBox__list__contents").animate({scrollTop: $('.commentBox__list__contents')[0].scrollHeight});
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    });
  });
});


