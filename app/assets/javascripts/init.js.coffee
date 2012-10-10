window.footnotes = {}


ajaxResponse = $.ajax
  url: '/ajax' + location.pathname + location.search
  dataType:'json'
  data:
    ajax_request: 'init'
    
ajaxResponse.done (pageData)->
  footnotes.data = pageData
        
