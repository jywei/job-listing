var ff
$.getJSON('/resumes/getExp', function(data){
  for(var i = 0; i < data.experience.length; i++){
    $('<ul><li>' + data.experience[i][0] + '</li>'
    + '<li>' + data.experience[i][1] + '</li>'
    + '<li>' + data.experience[i][2] + ' - ' + data.experience[3] + '</li>'
    + '<li>' + data.experience[i][4] + '</li>'
    + '<li>' + data.experience[i][5] + '</li>'
    + '<li>' + data.experience[i][6] + '</li>'
    + '<li>' + data.experience[i][7] + '</li>'
    + '<a herf="#" class="deleExp btn btn-danger" data-remote="true" data-id="' + data.experience[i][8] + '">Delete</a></ul>').appendTo($('.exp-form'))
    addExpDele('Exp')
  }
  if(data.djs.length != 0){
    for(var i = 0; i < data.djs.length; i++){
      $('<ul><li>' + data.djs[i].salary + '</li>'
      + '<a herf="#" class="deleDjs btn btn-danger" data-remote="true" data-id="' + data.djs[i].id + '">Delete</a></ul>').appendTo($('.djs-form'))
      addExpDele('Djs')
      $('#djs_button').hide()
    }
  }
  for(var i = 0; i < data.djr.length; i++){
    $('<ul><li>' + data.djr[i][0] + '</li>'
    + '<a herf="#" class="deleDjr btn btn-danger" data-remote="true" data-id="' + data.djr[i][1] + '">Delete</a></ul>').appendTo($('.djr-form'))
    addExpDele('Djr')
  }
  for(var i = 0; i < data.dji.length; i++){
    $('<ul><li>' + data.dji[i][0] + '</li>'
    + '<a herf="#" class="deleDji btn btn-danger" data-remote="true" data-id="' + data.dji[i][1] + '">Delete</a></ul>').appendTo($('.dji-form'))
    addExpDele('Dji')
  }
})

$('.exp_form').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addExp',
    data: { experience: { job_title: $('.exp_form #job_title').val(),
                          company_name: $('.exp_form #company_name').val(),
                          start_day: $('.exp_form #start_day').val(),
                          end_day: $('.exp_form #end_day').val(),
                          country_id: $('.exp_form #country_id').val(),
                          industry_id: $('.exp_form #industry_id').val(),
                          contract_type_id: $('.exp_form #contract_type_id').val(),
                          activities: $('.exp_form #activities').val() } },
    type: 'get',
    success: function(data) {

      if(data.error == undefined){
        $('<ul><li>' + data.experience[0] + '</li>'
        + '<li>' + data.experience[1] + '</li>'
        + '<li>' + data.experience[2] + ' - ' + data.experience[3] + '</li>'
        + '<li>' + data.experience[4] + '</li>'
        + '<li>' + data.experience[5] + '</li>'
        + '<li>' + data.experience[6] + '</li>'
        + '<li>' + data.experience[7] + '</li>'
        + '<a herf="#" class="deleExp btn btn-danger" data-remote="true" data-id="' + data.experience[8] + '">Delete</a></ul>').appendTo($('.exp-form'))
        addExpDele('Exp')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.experience.length; i++){
          $('<p>' + data.experience[i] + '</p>').appendTo($('.exp_error_zone'))
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

$('.djsform').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addDJS',
    data: { djs: { salary: $('.djsform #salary').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul><li>' + data.djs.salary + '</li>'
        + '<a herf="#" class="deleDjs btn btn-danger" data-remote="true" data-id="' + data.djs.id + '">Delete</a></ul>').appendTo($('.djs-form'))
        addExpDele('Djs')
        $('.modal').modal('hide')
        $('#djs_button').hide()
      }
      else{
        for(var i = 0; i < data.djs.length; i++){
          $('<p>' + data.djs[i] + '</p>').appendTo( ff.children($('.djs_error_zone')) )
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

$('.djrform').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addDJR',
    data: { djr: { category_id: $('.djrform #category_id').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul><li>' + data.djr[0] + '</li>'
        + '<a herf="#" class="deleDjr btn btn-danger" data-remote="true" data-id="' + data.djr[1] + '">Delete</a></ul>').appendTo($('.djr-form'))
        addExpDele('Djr')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.djr.length; i++){
          $('<p>' + data.djr[i] + '</p>').appendTo( ff.children($('.djr_error_zone')) )
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

$('.djiform').submit(function(){
  var ff = $(this)
  $.ajax({
    url: '/resumes/addDJI',
    data: { dji: { industry_id: $('.djiform #industry_id').val() } },
    type: 'get',
    success: function(data) {
      if(data.error == undefined){
        $('<ul><li>' + data.dji[0] + '</li>'
        + '<a herf="#" class="deleDji btn btn-danger" data-remote="true" data-id="' + data.dji[1] + '">Delete</a></ul>').appendTo($('.dji-form'))
        addExpDele('Dji')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.dji.length; i++){
          $('<p>' + data.dji[i] + '</p>').appendTo( ff.children($('.dji_error_zone')) )
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})

function addExpDele(name) {
  var ff
  $(".dele" + name).click(function(){
    ff = $(this)
    $.getJSON('/resumes/deleExp?id=' + $(this).data('id') + '&name=' + name, function(data){
      if(data == false) {
        ff.parent().remove()
      }
      if(name == 'Djs') {
        $('#djs_button').show()
      }
    })
  })
}

