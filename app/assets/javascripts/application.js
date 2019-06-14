// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require bootstrap-tagsinput.min

//= require_tree .





//タブ機能実装(開始)
//関数のshowTabの定義
function showTab(selector) {
  
  $(".tabs-menu li").removeClass("active");
  
  $(".tabs-menu a[href='" + selector + "']").parent("li").addClass("active");  

  $(".tabs-content > section").hide();
  $(selector).show();
  
}


//showTabの初期実行とクリックイベント定義。ページ遷移時も含む
$(document).on('turbolinks:load',function(){
  showTab("#tabs-1");
  
  //タブ一覧その1
  $(".tabs-menu a").click(function(){
    var selector = $(this).attr("href");
    showTab(selector);
    
    return false;
  });
  //タブ一覧その2
  showTab("#tabs-a");
  
  
  $(".tabs-menu a").click(function(){
    var selector = $(this).attr("href");
    showTab(selector);
    
    return false;
  });
});
//タブ機能(終了)


//アコーディオン(開始)
$(document).on('turbolinks:load',function(){
  $(".accordion-title").click(function(){
    
    var content = $(this).closest("section").find(".accordion-content");
    
    //コンテントが表示されていないなら
    if(!content.is(":visible")){
      content.slideDown();
    }
    else {
      content.slideUp()
    }
    
    return false;
  });
});


$(document).on('turbolinks:load', function(){
  $(".accordion-content").click(function(){
    
    var content = $(this).closest("section").find(".accordion-content");
    
    //コンテントが表示されていないなら
    if(!content.is(":visible")){
      content.slideDown();
    }
    else {
      content.slideUp()
    }
    
    return false;
  });
});
/* global $ */
//(終了)