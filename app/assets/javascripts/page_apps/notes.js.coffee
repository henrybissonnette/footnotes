
Footnotes.Notes = 
  init: ->
    console.log("using notes")
    @questions = new Footnotes.Collections.Questions Footnotes.Overlay.notes
    @overlay = new Footnotes.Views.OverlayView
      questions: @questions
    @overlay.render()
    $('#pseudo_body').load('/notes_for_url',{'external_url' : @external_url})