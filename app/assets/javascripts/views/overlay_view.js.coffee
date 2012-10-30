Footnotes.Views.OverlayView = Backbone.View.extend

  el: '#right_bar'

  events:
    'viewFootnote': 'onViewFootnote'
    'viewAll': 'onViewAll'

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

  onViewAll: ->
    @render()

  onViewFootnote: (event) ->
    @view = new Footnotes.Views.NoteFocusView
      model: event.model
      parentList: event.parentList
    @$el.html @view.render().el