$(document).ready( function() {
  checkCountry()
  $('#job_country_id').on("change", function(){
    checkCountry()
  })

  function checkCountry(){
    if ($('#job_country_id').val() == '150') {
      $('.job_location').show();
    }
    else {
      $('.job_location').hide();
    }
  }
})
