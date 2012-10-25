 window.Footnotes.Views.URIFinderView = class URIFinderView extends Backbone.View 
  el: 'form[name="URIFinder"]'

  events:
    'keyup input[name="external_url"]': 'validationCheck'
    'submit': 'onSubmit'

  initialize: ->
    @submit = @$el.find('input[type="submit"]')
    @submit.hide()

  validationCheck: ->
    if @validate()
      @submit.show()
    else
      @submit.hide()

  validate: ->  
    valid = false
    jax = $.ajax
      url: @$el.find('input[name="external_url"]').val()
      statusCode:
        200: =>
          valid = true
    valid

  onSubmit: (event) ->
    event.preventDefault()
    if @validate()
      @$el.submit()
