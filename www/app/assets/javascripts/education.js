var ff
$.getJSON('/resumes/getEdu', function(data){
  ff = data
})

$('.form').submit(function(){
  var ff = $(this)
  $.getJSON('/resumes/addSch?name=' + $('.form #name').val()
            + '&start_day=' + $('.form #start_day').val()
            + '&end_day=' + $('.form #end_day').val()
            + '&degree_level_id=' + $('.form #degree_level_id').val()
            + '&field_of_study=' + $('.form #field_of_study').val()
            + '&grade=' + $('.form #grade').val(), function(data){
    ff = data
    // for(var i = 0; i < data.)
  })
})
