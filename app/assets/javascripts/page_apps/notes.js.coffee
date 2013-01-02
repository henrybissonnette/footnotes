
Footnotes.Notes = 
  init: ->
    @questions = new Footnotes.Collections.Questions Footnotes.Overlay.notes
    @overlay = new Footnotes.Views.OverlayView
      questions: @questions
    @overlay.render()
    $('#pseudo_body').load('/notes_for_url',{'external_url' : @external_url})