window.Footnotes.Views.QuestionView = class QuestionView extends Backbone.View
  
  el: '.new'

  className: 'footnote'  

  render: ->
    @$el.append Footnotes.template('notes/QuestionView').render(@model.toJSON())
    return this

  closeNewForm: ->
    contents = Footnotes.template('newQuestion').render()
    @$el.html(contents).removeClass('form')
  
  newForm: ->
    newDiv = @$el.find('.new')
    view = new Footnotes.Views.NewQuestionFormView
    newDiv.html(view.render().el).addClass('form')