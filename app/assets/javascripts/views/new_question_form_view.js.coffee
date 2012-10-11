window.Footnotes.Views.NewQuestionFormView = Backbone.View.extend

  tagName: 'div'

  events:
    'click input[type="submit"]': 'submit'

  render: ->
    content = Footnotes.template('forms/newQuestionFormTemplate').render()
    @$el.append(content)
    submit = @$el.find('input[type="submit"]')
    submit.click (event) -> 
      event.preventDefault()
      
    return this

  submit: ->
    data = $('form').serializeArray()
    @model = new Footnotes.Models.Question 
    @model.save data