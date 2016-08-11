$(document).ready( function() {
  $('#job_location_id').show();
  $('#job_location_id').siblings($('label')).show();
  $('#job_country_id').on("change", function(){
    if ($('#job_country_id').val() == '150') {
      $('#job_location_id').show();
      $('#job_location_id').siblings($('label')).show();
    }
    else {
      $('#job_location_id').hide();
      $('#job_location_id').siblings($('label')).hide();
    }
  })
})
