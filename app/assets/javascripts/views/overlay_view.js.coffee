Footnotes.Views.OverlayView = Backbone.View.extend

  el: '#right_bar'

  events:
    'viewFootnote .footnote': 'showFootnote'

  initialize: (options) ->
    @questions = options.questions

  render: ->
    @$el.html Footnotes.template('overlayTemplate').render()
    @form = new Footnotes.Views.NewQuestionFormView
      questions: @questions
    @list = new Footnotes.Views.NoteListView   
      collection: @questions
    @$el.find('.new').html(@form.render().el)
    @$el.append @list.render()
    return this

  showFootnote: (event,model) ->
    @view = new Footnotes.Views.NoteFocusView
      model: model
    @$el.html @view.render().el