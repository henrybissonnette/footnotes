Footnotes.Views.OverlayView = Backbone.View.extend

  el: '#pseudobody'

  events:
    'viewFootnote': 'onViewFootnote'

  initialize: (options) ->
    @questions = options.questions
    @initialFocus = @questions.getByID Footnotes.Overlay.focusID

  render: ->
    if @initialFocus && !@initialFocus.isTopLevel()
      @onViewFootnote()
    else
      @$el.html Footnotes.template('overlayTemplate').render()
      @form = new Footnotes.Views.NewQuestionFormView
        questions: @questions
      @list = new Footnotes.Views.NoteListView   
        collection: @questions
      @$el.find('.new').html(@form.render().el)
      @$el.append @list.render().el
    @initialFocus = undefined
    return this

  onViewAll: ->
    @render()

  onViewFootnote: (event) ->
    if event
      model = event.model
    else 
      model = @initialFocus
    if model
      @view = new Footnotes.Views.NoteFocusView
        collection: @questions
        model: model
      @$el.html @view.render().el
    else
      @render()