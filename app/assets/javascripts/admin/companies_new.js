$(document).ready( function() {
  checkCountry()
  $('#company_country_id').on("change", function(){
    checkCountry()
  })

  function checkCountry(){
    if ($('#company_country_id').val() == '150') {
      $('.company_location').show();
    }
    else {
      $('.company_location').hide();
    }
  }
})
