Footnotes.Overlay = 

  init: ->
    # @questions = new Footnotes.Collections.Questions Footnotes.Overlay.notes
    # @overlay = new Footnotes.Views.OverlayView
    #   questions: @questions
    # @overlay.render()
    # $('#right_bar').load('/notes_for_url',{'external_url' : @external_url})
    contents = $.get('/notes_for_url',{'external_url' : @getExternalURL()},
      (response) => 
        $('#right_bar').html(response)
    )
    


  getExternalURL: ->
    if not @external_url
      query_string = location.search
      @external_url = query_string.match(/external_url=([^&]*)&?/)[1]
    else 
      @external_url


