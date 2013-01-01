Footnotes.Views.ResponseFormView = Backbone.View.extend

  events:
    'submit form': 'submit'
    'click .open': 'openForm'
    'click .close': 'onClose'

  initialize: (options) ->
    @parent = options.parent

  render: ->
    @closeForm()
    return this
      
  onClose: (event) ->
    event.preventDefault()
    @closeForm()

  closeForm: ->
    contents = $('<button>').addClass('open').text('reply')
    @$el.html contents
  
  openForm: ->
    context = 
      title:"Re: #{@parent.get('title')}"
    content = Footnotes.template('forms/questionFormTemplate').render(context)
    @$el.html content      

  submit: (event) ->
    event.preventDefault()
    data = Footnotes.formToObj @$('form')
    data['external_url'] = Footnotes.Overlay.getExternalURL()
    data['createdAt'] = (new Date).toISOString()
    data['parentID'] = @parent.get('id')
    @collection.create data
    @closeForm() 