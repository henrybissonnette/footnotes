window.Footnotes.Views.OverlayRightView = Backbone.View.extend

  el: '#right_bar'

  render: ->
    @$el.html Footnotes.template('overlayRightTemplate')
    @form = new Footnotes.Views.NewQuestionFormView
    @list = new Footnotes.Views.NoteListView   
      collection: new Footnotes.Collections.Questions
    @$el.append(@form.render())
    @$el.append(@list.render())
    return this