Footnotes.Views.NoteFocusView = Backbone.View.extend

  render: ->
    @focalNote = new Footnotes.Views.FocalNoteView
      model: @model
    @form = new Footnotes.Views.ResponseFormView
      parent: @model
    @responses = new Footnotes.Views.NoteListView
      collection: @model.get 'children'
    @$el.append @responses.render().el
    @$el.append @focalNote.render().el
    @$el.append @form.render().el
    return this