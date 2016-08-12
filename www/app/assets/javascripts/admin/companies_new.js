$(document).ready( function() {
  checkCountry()
  $('#company_country_id').on("change", function(){
    checkCountry()
  })

  function checkCountry(){
    if ($('#company_country_id').val() == '150') {
      $('#company_location_id').show();
      $('#company_location_id').siblings($('label')).show();
    }
    else {
      $('#company_location_id').hide();
      $('#company_location_id').siblings($('label')).hide();
    }
  }
})
