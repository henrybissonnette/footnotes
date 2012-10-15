window.Footnotes.Views.OverlayRightView = Backbone.View.extend

  el: '#right_bar'

  initialize: (options) ->
    @questions = options.questions

  render: ->
    @$el.html Footnotes.template('overlayRightTemplate').render()
    @form = new Footnotes.Views.NewQuestionFormView
      questions: @questions
    @list = new Footnotes.Views.NoteListView   
      collection: @questions
    @$el.append(@form.render())
    @$el.append(@list.render())
    return this