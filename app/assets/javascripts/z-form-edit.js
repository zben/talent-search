$(document).ready(function() {


  $(".collapse").collapse();
    $('label').removeClass('label');
  $('li.fragment select').addClass('date');
    $('.actions').removeClass('actions');
  $('.skill_list').hide();  
  $(".yearmonth ol li:nth-child(3) select.date").hide()
  $(".yearonly ol li:nth-child(3) select.date").val('1').hide()
  $(".yearonly ol li:nth-child(2) select.date").val('1').hide()

});

