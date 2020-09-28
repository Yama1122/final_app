$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="product[product_images_attributes][${num}][src]"
                    id="product_product_images_attributes_${num}_src"><br>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
       const html = `<div class= "previewimg">
                      <img data-index="${index}" src="${url}" width="100px" height="100px">
                      <hr class="border-style">
                      <div class="js-remove">削除</div>
                     </div>`;
     return html;
  }
  
  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
　//クリックされた時に発火させる 
  $("#images__upload").on("click", function(e){
    let last_field = $(`.js-file`).last();
    last_field.trigger("click");
  });
  
  // 
  $('#image-box').on('change', `input[type="file"]`, function(e) {
    const targetIndex = $(this).parent().data('index');


    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('.images__upload-box').before(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      // 画像が１０枚投稿されたら.images__upload-boxを消す
      let num = $('.previewimg').length
      if (num == 10){
        $('.images__upload-box').css('display', 'none')
      }
    }
  });

  $('#images__upload').on('dragover drop',function(e){
    e.preventDefault();
    e.stopPropagation();
    $('#images__upload').css('border', '1px solid #333');
    });

  $('#images__upload').on('dragleave',function(e){
    e.preventDefault();
    e.stopPropagation();
    $('#images__upload').css('border', '1px dashed #aaa');
    });

    var target = $(".js-file");
      
    target.on("drop",function(e){
      $(".js-file").prop('files',e.originalEvent.daraTransfer.files);
      console.log("123")
      var reader = new FileReader();
      reader.onload = function(e){
        target.attr('src', e.target.result);
      }
      reader.readAsDataURL(e.originalEvent.daraTransfer.files[0]);
    });
       


    //   var target = document.getElementById('images__upload');
    // target.addEventListener('dragover', function (e) {
    //   e.preventDefault();
    //   e.stopPropagation();
    //   e.dataTransfer.dropEffect = 'copy';
    // });
    // target.addEventListener('drop', function (e) {
    //   e.stopPropagation();
    //   e.preventDefault();
    //   const reader = new FileReader();
    //   reader.onload = function (e) {
    //     document.getElementById('previews').src = e.target.result;
    //     console.log("123")
    //   }
    //   reader.readAsDataURL(e.dataTransfer.files[0]);
    // });
  //  let dropArea = document.getElementById("test");
  //    dropArea.addEventListener("draghover",function(e){
  //       e.preventDefault();
  //       e.stopPropagation();
  //      $(this).children('#images__upload').css({'border': '1px solid rgb(240, 204, 204)','box-shadow': '0px 0px 4px'})
  //    },false);

  //    dropArea.addEventListener("dragleave", function(e){
  //     e.preventDefault();
  //      $(this).children('#images__upload').css({'border': '1px solid rgb(240, 204, 204)','box-shadow': '0px 0px 0px'})
  //    },false);

  //    dropArea.addEventListener("drop", function(e) {
  //     e.preventDefault();
  //     e.stopPropagation();
  //     console.log("123")  
  //     $(this).children('#images__upload').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'});
  //    });


  $('.upload-area').on('click', '.js-remove', function() {
    const targetIndex = $(this).prev().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
      $(this).parent().remove();
      $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});
