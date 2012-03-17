jQuery ->
  states = $('#ind_user_profile_attributes_province_id').html()
  $('#ind_user_profile_attributes_residence_country').change ->

    country = $('#ind_user_profile_attributes_residence_country :selected').text()

    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
   
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#ind_user_profile_attributes_province_id').html(options)
    else
      $('#ind_user_profile_attributes_province_id').empty()
  $('#ind_user_profile_attributes_residence_country').change()
