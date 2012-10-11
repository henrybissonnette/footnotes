window.Footnotes.Views.NewQuestionFormView = Backbone.View.extend

  el: '.new'

  events:
    'click input[type="submit"]': 'submit'
    'click .open': 'openForm'
    'click .close': 'closeForm'

  initialize: ->
    form_open = false

  render: ->
    content = Footnotes.template('forms/newQuestionFormTemplate').render()
    @$el.append content
    submit = @$el.find 'input[type="submit"]'
    submit.click (event) -> 
      event.preventDefault()
    return this
      
  closeForm: ->
    contents = Footnotes.template('newQuestion').render()
    @$el.html contents
    @form_open = false
  
  openForm: ->
    newDiv = @$el.find '.new'
    @$el.html render()
    @form_open = true


  submit: ->
    data = $('form').serializeArray()
    @model = new Footnotes.Models.Question 
    @model.save data
    closeForm()