
$(document).ready(function(){
  var ignore_first = 1
  $('#focal_item').load(function(){
    ignore_first -= 1
    if (ignore_first){
      var target_url = this.contentWindow.location.href
      target_url = "/overlay?external_url="+target_url
      window.location.replace(target_url)
    } 
  })
})
