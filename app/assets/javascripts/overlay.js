
$(document).ready(function(){
  var ignore_first = 1;
  $('#focal_item').load(function(){
    ignore_first -= 1;
    if (ignore_first){
      var target_url = this.contentWindow.location.href;
      var parser = document.createElement('a');
      parser.href = target_url
      target_url = "/overlay"+parser.search;
      window.location.replace(target_url);
    } ;
  })
})
