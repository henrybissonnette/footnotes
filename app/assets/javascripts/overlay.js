

$(document).ready(function(){
  var ignore_first = 1
  $('#focal_item').change(function(){
    ignore_first -= 1
    if (ignore_first){
      window.location.replace(this.contentWindow.location.href.replace('overlay/proxy?','overlay?'))
    } 
  })
})