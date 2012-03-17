jQuery ->

  cities = $('#job_post_city_id').html()
  $('#job_post_province_id').change ->
    province = $('#job_post_province_id :selected').text()
    options = $(cities).filter("optgroup[label='#{province}']").html()
    if options
      $('#job_post_city_id').html(options)

    else
      $('#job_post_city_id').empty()
  $('#job_post_province_id').change()
