Footnotes.Views.NoteListView = Backbone.View.extend

  el: '.notes'

  initialize: ->
    @collection.on('add', @renderQuestions, @)
    @collection.on('reset', @renderQuestions, @)

  render: ->
    @renderQuestions()
    return this
    # show spinner

  renderQuestions: ->  
    @$el.empty()
    @collection.each (question) => 
      view = new Footnotes.Views.QuestionView
            model: question
      @$el.append(view.render().el)
    # hide spinner  

