$(function(){
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
    },
    mouseleave: function () {
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
    },
    mouseenter: function () {
    }
  }, '#tree_menu');
});
