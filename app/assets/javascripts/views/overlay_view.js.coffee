Footnotes.Views.OverlayView = Backbone.View.extend

  el: '#right_bar'

  events:
    'viewFootnote': 'onViewFootnote'

  initialize: (options) ->
    @questions = options.questions

  render: ->
    @$el.html Footnotes.template('overlayTemplate').render()
    @form = new Footnotes.Views.NewQuestionFormView
      questions: @questions
    @list = new Footnotes.Views.NoteListView   
      collection: @questions.getTopNotes()
    @$el.find('.new').html(@form.render().el)
    @$el.append @list.render()
    return this

  onViewAll: ->
    @render()

  onViewFootnote: (event) ->
    model = event.model
    if model
      @view = new Footnotes.Views.NoteFocusView
        collection: @questions
        model: event.model
      @$el.html @view.render().el
    else
      @render()