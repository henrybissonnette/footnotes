window.Footnotes.Views.QuestionView = class QuestionView extends Backbone.View
  
  tagName: 'div'

  className: 'footnote' 

  events: 
    'click .title' : 'toggleView'
    'click .edit' : 'edit'
    'click .close' : 'close'
    'click .delete' : 'delete'
    'submit form': 'submit'

  initialize: ->
    @model.bind("change",@render,@)
    @model.bind("destroy", @clear,@)
 
  render: ->
    @$el.html Footnotes.template('notes/QuestionView').render(@context())
    return this

  toggleView: ->
    others = @$el.find('.title').siblings()
    others.each ->
      if $(this).is(":visible")
        $(this).hide()
      else
        $(this).show()

  edit: ->
    form = Footnotes.template('forms/newQuestionFormTemplate').render(@context())
    @$el.html(form)

  delete: ->
    if confirm("Permanently delete #{@model.get("title")}?")
      @model.destroy()

  clear: ->
    @$el.remove()

  context: ->
    title: @model.get("title")
    creatorName: @model.get("creatorName")
    canEdit: Footnotes.Overlay.currentUser.get('username') == @model.get('creatorName')
    content: @model.get("content")
    id: @model.get("id")


  close: ->
    @render()

  submit: (event) ->
    event.preventDefault()
    data = Footnotes.formToObj @$('form')
    @model.save data
    @close()   