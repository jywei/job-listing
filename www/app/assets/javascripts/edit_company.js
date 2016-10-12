$('#company_image').change(function(){
  var files = !!this.files ? this.files : [];
  if (!files.length || !window.FileReader) return;
  if (/^image/.test( files[0].type)){
    var reader = new FileReader();
    reader.readAsDataURL(files[0]);
    reader.onloadend = function(){
      $(".image_display_zone").attr("src", this.result);
    }
  }
})

$('#company_cover').change(function(){
  var files = !!this.files ? this.files : [];
  if (!files.length || !window.FileReader) return;
  if (/^image/.test( files[0].type)){
    var reader = new FileReader();
    reader.readAsDataURL(files[0]);
    reader.onloadend = function(){
      $(".cover_display_zone").attr("src", this.result);
    }
  }
})
