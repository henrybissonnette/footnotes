Footnotes.Overlay = 

  init: ->
    @overlay = new Footnotes.Views.OverlayRightView
    @overlay.render()

  #   ajaxResponse = $.ajax
  #     url: '/footnotes/get' + location.search
  #     dataType:'json'
  #     data:
  #       ajax_request: 'init'

    
  #   ajaxResponse.done (pageData) ->
  #     questionNotes =  new Footnotes.Collections.Questions pageData
  #     noteListView = new Footnotes.Views.NoteListView
  #       collection: questionNotes
  #     container = $('#footnotes')
  #     container.empty()
  #     container.append(noteListView.render().el)