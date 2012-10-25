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
      overlay_fail = search.match(/overlay_fail=([^&]*)/)[1]
      window.location.replace "/?overlay_fail=#{overlay_fail}"
    if ignore_first
      target_url = "/overlay"+search
      window.location.replace target_url