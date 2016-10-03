$('.delete_contact').click(function(){
  var current_object = $(this)
  $.ajax({
    url: '/admin/delete_contact',
    data: { id: $(this).data('id') },
    type: 'get',
    success: function(data) {
      alert('Successfully deleted')
      current_object.parent().parent().remove()
    },
    failure: function() {
      alert('unsuccess')
    }
  })
})
