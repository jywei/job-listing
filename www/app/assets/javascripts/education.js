var ff
$.getJSON('/resumes/getEdu', function(data){
  for(var i = 0; i < data.school.length; i++){
    $('<ul class="deleSch"><li>' + data.school[i][0] + '</li>'
    + '<li>' + data.school[i][1] + ' - ' + data.school[i][2] + '</li>'
    + '<li>Degree Level : ' + data.school[i][3] + '</li>'
    + '<li>Field of Study : ' + data.school[i][4] + '</li>'
    + '<li>Grade : ' + data.school[i][5] + '</li></ul>'
    + '<a herf="#" class="deleLoca btn btn-danger" data-remote="true" data-id="' + data.school[i][6] + '">Delete</a>').appendTo($('.sch-form'))
    addDele('Sch')
  }
})

$('.form').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addSch',
    data: { school: { university_id: $('.form #university_id').val(),
                      start_day: $('.form #start_day').val(),
                      end_day: $('.form #end_day').val(),
                      degree_level_id: $('.form #degree_level_id').val(),
                      field_of_study: $('.form #field_of_study').val(),
                      grade: $('.form #grade').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul class="deleSch"><li>' + data.school[0] + '</li>'
        + '<li>' + data.school[1] + ' - ' + data.school[2] + '</li>'
        + '<li>Degree Level : ' + data.school[3] + '</li>'
        + '<li>Field of Study : ' + data.school[4] + '</li>'
        + '<li>Grade : ' + data.school[5] + '</li></ul>').appendTo($('.sch-form'))
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.school.length; i++){
          console.log(data.school[i])
          $('<p>' + data.school[i] + '</p>').appendTo($('.error_zone'))
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

function addDele(name) {
  var ff
  $(".dele" + name).click(function(){
    ff = $(this)
    $.getJSON('/resumes/deleEdu?id=' + $(this).data('id') + '&name=' + name, function(data){
      if(data != false) {
        ff.parent().parent().remove()
      }
    })
  })
}
