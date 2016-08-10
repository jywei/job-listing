var ff
$.ajax({
  url: "/admin/getCompany",
  type: "GET",
  dataType: "json",
  success: function(data){
    alert('success')
    ff = data
    for(var i = 0; i < data.companies.length; i++){
      $('<tr>' +
          '<td>' + data.companies[i].name + "</td>" +
          '<td>' + data.companies[i].tagline + "</td>" +
          '<td>' + data.companies[i].phone + "</td>" +
          '<td>' + data.companies[i].email + '</td>' +
          '<td>' + data.companies[i].about + '</td>' +
          '<td>' + data.companies[i].android + '</td>' +
          '<td>' + data.companies[i].facebook + '</td>' +
          '<td>' + data.companies[i].idea + '</td>' +
          '<td>' + data.companies[i]. + '</td>' +
          '<td>' + data.companies[i]. + '</td>' +
          '<td>' + data.companies[i]. + '</td>' +
          '<td>' + data.companies[i]. + '</td>' +
      ).appendTo($('tbody'))
    }
  },
  error: function(){
    alert('error')
  }
})
