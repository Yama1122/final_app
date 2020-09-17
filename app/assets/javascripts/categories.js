$(function(){
// ---topページここから---

  // カテゴリアイコンをホバーするとメニュ-を表示
  $(".listsleft__item--first").hover(function(e){  
    e.preventDefault();
    $('#tree_menu').show();
    $('.categoryTree').show();  
  });

// 子カテゴリに追加する要素
  function childBuild(children){ 
    let child_category = `<li class="category_child">
                            <a href="/categories/${children.id}"><input class="child_btn" type="button" value="${children.name}" name= "${children.id}">
                            </a>
                          </li>
                        `;

    return child_category;
  }
// 孫カテゴリに追加する要素
  function gcBuild(children) {
    let gc_category = `
                      <li class="category_grandchild">
                        <a href="/categories/${children.id}"><input class="gc_btn" type="button" value="${children.name}" name= "${children.id}">
                        </a>
                      </li>
                      `;
    return gc_category;
  }

// 親カテゴリの一つ一つの要素をホバーすると子カテゴリに要素を追加
  $('.parent_btn').hover(function () {
    // 親カテゴリの要素のidを取得
    let categoryParent = $(this).attr('name');
    $.ajax({
      url: '/categories/search',
      type: 'GET',
      data: {
        parent_id: categoryParent
      },
      dataType: 'json'
    })
    .done(function (data) {
      $(".categoryTree-grandchild").hide();
      $(".category_child").remove();
      $(".category_grandchild").remove();
      $('.categoryTree-child').show();
      data.forEach(function (child) {
        let child_html = childBuild(child);
        $(".categoryTree-child").append(child_html);
      });
    })
    .fail(function () {
      alert("カテゴリーを選択してください");
    });
  });

// 子カテゴリー要素をホバーすると孫カテゴリを表示
// 動的に生成される要素にはhoverが使えないので.on〜
  $(document).on({
    mouseenter: function () {
      let categoryChild = $(this).attr('name');
      $.ajax({
          url: '/categories/search',
          type: 'GET',
          data: {
            children_id: categoryChild
          },
          dataType: 'json'
        })
        .done(function (gc_data) {
          $(".category_grandchild").remove();
          $('.categoryTree-grandchild').show();
          gc_data.forEach(function (gc) {
            let gc_html = gcBuild(gc)
            $(".categoryTree-grandchild").append(gc_html);
          });
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    }
  }, '.child_btn');  // $(document)で親要素である.child_btnを指定

// マウスが離れたときに非表示にする
  $(document).on({
    mouseleave: function (e) {
      e.preventDefault();
      $(".categoryTree-grandchild").hide();
      $(".categoryTree-child").hide();
      $(".categoryTree").hide();
      $(this).hide();
      $(".category_child").remove();
      $(".category_grandchild").remove();
    }
  }, '#tree_menu');
// ---topページここまで---


// ---商品出品ページここから---

  // カテゴリ選択ボックス内のoptionを追加
  function buildOption(child){
    let html = `<option value="${child.id}">${child.name}</option>`;
    return html;
  }

  // 子カテゴリの選択ボックスを追加
  function buildChild(insertHTML) {
    let html = `<div class="category__list_box--child">
                  <select class="text" id="child-form" name="child">
                    <option value="">---</option>  //初期値の設定
                    ${insertHTML}
                  </select>
                </div>
              `
    return html;
  }

  // 孫カテゴリの選択ボックスを追加
  function buildGrandChild(insertHTML) {
    var html = `
                <div class="category__list_box--gc">
                  <select class="text" id="grandchild-form" name="product[category_id]">
                    <option value="">---</option>
                    ${insertHTML}
                  </select>
                </div>
              `
    return html;
  }

  // 親カテゴリを選択すると子カテゴリを表示
  $("#parent-form").on("change", function(){
    let parentValue = document.getElementById("parent-form").value;
    if (parentValue != '') {  //選択した親要素が初期値以外なら動作
      $.ajax({
        url: '/categories/search',
        type: "GET",
        data: {
          parent_id: parentValue
        },
        dataType: 'json'
      })
      .done(function(data){
        let insertHTML = '';
        data.forEach(function(child){
          insertHTML += buildOption(child);
        });
        let html = buildChild(insertHTML);
        $('.category__list_box').append(html);
        $("#parent-form").on("change", function(){
          $(".category__list_box--child").remove();  //親カテゴリ選択時に子・孫カテゴリをリセット
          $(".category__list_box--gc").remove();
          $(".brand").remove();
        });

        // 子カテゴリを選択すると孫カテゴリを表示
        $("#child-form").on("change", function(){
          let childrenValue = document.getElementById("child-form").value;
          if (childrenValue != '') {
            $.ajax({
              url: '/categories/search',
              type: "GET",
              data: {
                children_id: childrenValue
              },
              dataType: 'json'
            })
            .done(function(data){
              // 孫カテゴリのデータがある・ないで分岐
              let length = data.length
              // 孫カテゴリがない場合ブランドを追加
              if (length == 0) {
                $('.brand').css("display", "block");
              // 孫カテゴリがある場合
              } else {
                let insertHTML = '';
                data.forEach(function(grandchild){
                  insertHTML += buildOption(grandchild);
                });
                let html = buildGrandChild(insertHTML);
                $('.category__list_box').append(html);
                // 孫カテゴリ選択でブランドが表示
                $("#grandchild-form").on("change", function(){
                  $('.brand').css("display", "block");
                });
              }
              $("#child-form").on("change", function(){
                $(".category__list_box--gc").remove();  //再度,子カテゴリ選択で孫カテゴリリセット
                $(".brand").hide();
              });
            })
            .fail(function(){
              alert('カテゴリー取得に失敗しました');
            })
          }
        });
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }
  });

// ---商品出品ページここまで---

});
