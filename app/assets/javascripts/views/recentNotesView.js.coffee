window.Footnotes.Views.RecentNotesView = Backbone.View.extend
  
  el: '#recent_notes'

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
      view = new Footnotes.Views.staticQuestionView
            model: question
      @$el.append(view.render().el)