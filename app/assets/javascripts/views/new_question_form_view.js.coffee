window.Footnotes.Views.NewQuestionFormView = Backbone.View.extend

  el: '.new'

  events:
    'submit form': 'submit'
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

  submit: (event) ->
    event.preventDefault()
    data = Footnotes.formToObj @$('form')
    data['external_url'] = Footnotes.Overlay.getExternalURL()
    data['createdAt'] = (new Date).toISOString()
    @questions.create data
    @closeForm() 
