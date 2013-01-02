Footnotes.Views.NoteListView = Backbone.View.extend
  initialize: (options) ->
    @focus = options.focus
    @collection.on('sync', @render, @)
    
  render: ->
    if @focus
      @notes = @collection.getChildren @focus
    else
      @notes = @collection.getTopNotes()
    @renderQuestions()
    return this
    # show spinner

  renderQuestions: ->  
    @$el.empty()
    @notes.each (question) => 
      view = new Footnotes.Views.QuestionView
            model: question
      @$el.append(view.render().el)
    # hide spinner  

