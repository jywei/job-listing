  var ff
  $.getJSON('http://www.moedict.tw/raw/' + '我', function(data){
    ff = data
    $(data.non_radical_stroke_count + data.radical + data.title).appendTo($('tbody'))
  })
