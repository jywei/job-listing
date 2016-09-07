var ff
$.getJSON('/resumes/getEdu', function(data){
  for(var i = 0; i < data.school.length; i++){
    $('<ul class="Sch"><li>' + data.school[i][0] + '</li>'
    + '<li>' + data.school[i][1] + ' - ' + data.school[i][2] + '</li>'
    + '<li>Degree Level : ' + data.school[i][3] + '</li>'
    + '<li>Field of Study : ' + data.school[i][4] + '</li>'
    + '<li>Grade : ' + data.school[i][5] + '</li>'
    + '<a herf="#" class="deleSch btn btn-danger" data-remote="true" data-id="' + data.school[i][6] + '">Delete</a></ul>').appendTo($('.sch-form'))
    addDele('Sch')
  }
  for(var i = 0; i < data.language.length; i++){
    $('<ul class="Lan"><li>' + data.language[i][0] + '</li>'
    + '<li>' + data.language[i][1] + '</li>'
    + '<a herf="#" class="deleLan btn btn-danger" data-remote="true" data-id="' + data.language[i][2] + '">Delete</a></ul>').appendTo($('.lan-form'))
    addDele('Lan')
  }
  for(var i = 0; i < data.skill.length; i++){
    $('<ul><li>' + data.skill[i].name + '</li>'
    + '<a herf="#" class="deleSki btn btn-danger" data-remote="true" data-id="' + data.skill[i].id + '">Delete</a></ul>').appendTo($('.ski-form'))
    addDele('Ski')
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
        $('<ul class="Sch"><li>' + data.school[0] + '</li>'
        + '<li>' + data.school[1] + ' - ' + data.school[2] + '</li>'
        + '<li>Degree Level : ' + data.school[3] + '</li>'
        + '<li>Field of Study : ' + data.school[4] + '</li>'
        + '<li>Grade : ' + data.school[5] + '</li>'
        + '<a herf="#" class="deleSch btn btn-danger" data-remote="true" data-id="' + data.school[6] + '">Delete</a></ul>').appendTo($('.sch-form'))
        addDele('Sch')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.school.length; i++){
          $('<p>' + data.school[i] + '</p>').appendTo($('.sch_error_zone'))
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

$('.lanform').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addLan',
    data: { language: { language_skill_id: $('.lanform #lan-name').val(),
                        proficiency_id: $('.lanform #proficiency_id').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul class="Lan"><li>' + data.language[0] + '</li>'
        + '<li>' + data.language[1] + '</li>'
        + '<a herf="#" class="deleLan btn btn-danger" data-remote="true" data-id="' + data.language[2] + '">Delete</a></ul>').appendTo($('.lan-form'))
        addDele('Lan')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.language.length; i++){
          $('<p>' + data.language[i] + '</p>').appendTo( ff.children($('.lan_error_zone')) )
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

$('.skiform').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addSki',
    data: { skill: { name: $('.skiform #ski-name').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul><li>' + data.skill.name + '</li>'
        + '<a herf="#" class="deleSki btn btn-danger" data-remote="true" data-id="' + data.skill.id + '">Delete</a></ul>').appendTo($('.ski-form'))
        addDele('Ski')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.skill.length; i++){
          $('<p>' + data.skill[i] + '</p>').appendTo( ff.children($('.ski_error_zone')) )
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
      if(data == false) {
        ff.parent().remove()
      }
    })
  })
}

