Footnotes.User = 

  init: ->
    @notes = new Footnotes.Collections.Questions Footnotes.User.myNotes
    @myNotes = new Footnotes.Views.RecentNotesView 
                      collection: @notes
    $('#myNotes').append @myNotes.render().el