Footnotes.Overlay = 

  init: ->
    @questions = new Footnotes.Collections.Questions
    @questions.fetch()
    @overlay = new Footnotes.Views.OverlayRightView
      questions: @questions
    @overlay.render()

  getExternalURL: ->
    if not @external_url
      query_string = location.search
      @external_url = query_string.match(/&external_url=([^&]*)&?/)[1]
    else 
      @external_url


