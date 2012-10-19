window.Footnotes.Views.RecentNotesView = Backbone.View.extend

  initialize: ->
    @collection.on('add', @renderQuestions, @)
    @collection.on('reset', @renderQuestions, @)

  render: ->
    @renderQuestions()
    return this
    # show spinner

  renderQuestions: ->  
    @collection.each (question) => 
      view = new Footnotes.Views.staticQuestionView
            model: question
      @$el.append(view.render().el)