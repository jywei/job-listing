var ff
$.ajax({
  url: "/admin/getCompany",
  type: "GET",
  dataType: "json",
  success: function(data){
    ff = data
    for(var i = 0; i < data.companies.length; i++){
      $('<tr>'
          + '<td>' + data.companies[i].name + "</td>"
          + '<td>' + data.companies[i].tagline + "</td>"
          + '<td>' + data.companies[i].phone + "</td>"
          + '<td>' + data.companies[i].email + '</td>'
          + '<td>' + data.companies[i].about + '</td>'
          + '<td>' + data.companies[i].story + '</td>'
          + '<td>' + data.companies[i].welfare + '</td>'
          + '<td>' + data.companies[i].demand + '</td>'
          + '<td>' + data.companies[i].website + '</td>'
          + '<td>' + data.companies[i].ios + '</td>'
          + '<td>' + data.companies[i].android + '</td>'
          + '<td>' + data.companies[i].facebook + '</td>'
          + '<td>' + data.companies[i].twitter + '</td>'
          + '<td>' + data.companies[i].idea + '</td>'
          + '<td>' + data.companies[i].jobs_count + '</td>'
        + '</td>'
      ).appendTo($('tbody'))
    }
  },
  error: function(){
    alert('error')
  }
})
