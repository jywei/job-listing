$('.submit-contact-us').click(function(){
  $.ajax({
    url: '/pages/contact_us',
    data: { contact: { name: $('#name').val(),
                       phone: $('#phone').val(),
                       email: $('#email').val(),
                       message: $('#message').val() } },
    type: 'get',
    success: function(data) {
      $('.error_zone').children().remove()
      if(data.error == undefined){
        alert('Email submit successfully!')
        $('.modal').modal('hide')
      }
      else{
        for(var i = 0; i < data.contact.length; i++){
          $('<p>' + data.contact[i] + '</p>').appendTo($('.error_zone'))
        } 
      }
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})
