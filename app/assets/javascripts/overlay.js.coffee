$ ->
  ignore_first = true
  $('#focal_item').load ->
    ignore_first = ignore_first == false
    if ignore_first
      target_url = this.contentWindow.location.href
      parser = document.createElement('a')
      parser.href = target_url
      target_url = "/overlay"+parser.search
      window.location.replace target_url