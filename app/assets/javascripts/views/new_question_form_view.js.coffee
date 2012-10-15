window.Footnotes.Views.NewQuestionFormView = Backbone.View.extend

  el: '.new'

  events:
    'click input[type="submit"]': 'submit'
    'click .open': 'openForm'
    'click .close': 'closeForm'

  initialize: (options) ->
    @questions = options.questions

  render: ->
    @closeForm()
    return this
      
  closeForm: ->
    contents = Footnotes.template('newQuestion').render()
    @$el.html contents
  
  openForm: ->
    content = Footnotes.template('forms/newQuestionFormTemplate').render()
    @$el.html content
    submit = @$el.find 'input[type="submit"]'
    submit.click (event) -> 
      event.preventDefault()

  submit: ->
    data = Footnotes.formToObj $('form')
    data['external_url'] = Footnotes.Overlay.getExternalURL()
    #@model = new Footnotes.Models.Question 
    @questions.create data
    #@model.save data
    @closeForm()
