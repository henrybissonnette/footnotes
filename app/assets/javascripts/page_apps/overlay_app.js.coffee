Footnotes.Overlay = 

  init: ->
    contents = $.get('/notes_for_url',
      {
        'external_url' : @getExternalURL(),
        'focusID' : Footnotes.Overlay.focusID
      },
      (response) => 
        $('#right_bar').html(response)
    )
    


  getExternalURL: ->
    if not @external_url
      query_string = location.search
      @external_url = query_string.match(/external_url=([^&]*)&?/)[1]
    else 
      @external_url


