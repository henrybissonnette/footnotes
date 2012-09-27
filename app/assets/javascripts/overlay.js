

$(document).ready(function(){
  var ignore_first = 1
  $('#focal_item').load(function(){
    ignore_first -= 1
    if (ignore_first){
      window.location.replace(this.contentWindow.location.href.replace('overlay/proxy?','overlay?'))
    } 
  })
})