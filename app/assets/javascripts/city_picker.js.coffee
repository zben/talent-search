jQuery ->

  cities = $('#city_id select').html()
  $('#province_id select').change ->
    province = $('#province_id select :selected').text()
    options = $(cities).filter("optgroup[label='#{province}']").html()
    if options
      $('#city_id select').html(options)

    else
      $('#city_id select').empty()

