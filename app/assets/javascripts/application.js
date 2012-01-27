// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $('#skill_picker').click(function(event){ 
    if($(this).text() == '查看所有技能'){
       $('.skill_list').show();
       $(this).text('不使用选择列表');
       $('.skill_list input').attr("disabled", false);
     }
     else{
       $('.skill_list').hide();
       $(this).text('查看所有技能');
       $('.skill_list input').attr("disabled", true);
     }
     event.preventDefault();
  });

  initDynamicOptionLists();


  


});


