Footnotes.Home = 

  init: ->
    @recent = new Footnotes.Collections.Questions Footnotes.Home.recentNotes
    @recentNotes = new Footnotes.Views.RecentNotesView 
                      collection: @recent
    $('#recent_notes').append(@recentNotes.render().el)