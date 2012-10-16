Footnotes.Home = 

  init: ->
    @currentUser = new Footnotes.Models.User Footnotes.currentUser
    @recent = new Footnotes.Collections.Questions Footnotes.Home.recentNotes
    @recentNotes = new Footnotes.Views.RecentNotesView 
                      collection: @recent
    @recentNotes.render()