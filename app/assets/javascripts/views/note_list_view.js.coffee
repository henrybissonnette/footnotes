window.Footnotes.Views.NoteListView = Backbone.View.extend

  tagName: 'div'

  events:
    'click .new:not(.form)': 'newForm'
    'click .new .cancel': 'cancelNewForm'

  initialize: ->
    @collection.bind('reset', this.render, this)

  render: ->
    @$el.html(Footnotes.template('lists/noteListViewTemplate').render())
    notes = @$el.find('.notes')
    @collection.each (question) -> 
      view = new Footnotes.Views.QuestionView
            model: question
      notes.append(view.render().el)
    return this

  cancelNewForm: ->
    newDiv = @$el.find('.new')
    contents = Footnotes.template('newQuestion').render()
    newDiv.html(contents).removeClass('form')
  
  newForm: ->
    newDiv = @$el.find('.new')
    view = new Footnotes.Views.NewQuestionFormView
    newDiv.html(view.render().el).addClass('form')