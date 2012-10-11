window.Footnotes.Views.NoteListView = Backbone.View.extend

  el: '.notes'

  initialize: ->
    #@getNotes()
    @collection.on('change', @renderQuestions, @)
    @collection.fetch()

  render: ->
    @$el.html(Footnotes.template('lists/noteListViewTemplate').render())
    @notes = @$el.find('.notes')
    # show spinner

  renderQuestions: ->  
    @collection.each (question) -> 
      view = new Footnotes.Views.QuestionView
            model: question
      @notes.append(view.render().el)
    # hide spinner  
    return this

  # getNotes: ->
  #   ajaxResponse = $.ajax
  #     url: '/footnotes/get' + location.search
  #     dataType:'json'
  #     data:
  #       ajax_request: 'init'
    
  #   ajaxResponse.done (pageData) -> 
  #     @collection = new Footnotes.Collections.Questions pageData
  #     @collection.bind('reset', this.render, this)
