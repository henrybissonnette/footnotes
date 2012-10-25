$ ->
  ignore_first = true
  $('#focal_item').load ->
    ignore_first = ignore_first == false
    target_url = this.contentWindow.location.href
    parser = document.createElement('a')
    parser.href = target_url
    search = parser.search
    try 
      external_url = search.match(/external_url=([^&]*)/)[1]
    catch error
      window.location.replace '/?fail=#{external_url}'
    if ignore_first
      target_url = "/overlay"+search
      window.location.replace target_url