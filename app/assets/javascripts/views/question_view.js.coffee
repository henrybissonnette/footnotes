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
    @$el.addClass @model.get('noteType')
    @$el.attr('id',"#{@model.get("noteType")}#{@model.get("id")}")
 
  render: ->
    @$el.html Footnotes.template('notes/questionTemplate').render(@context())
    return this

  toggleView: ->
    others = @$el.find('.title').siblings()
    typeIndicator = @$(".type_indicator")
    typeIndicator.remove()
    others.each ->
      if $(this).is(":visible")
        $(this).siblings(".title").addClass('minimized')
        $(this).siblings(".title").prepend(typeIndicator)
        $(this).hide()
      else
        $(this).siblings(".title").removeClass('minimized')
        $(this).siblings(".content").prepend(typeIndicator)
        $(this).show()

  edit: ->
    form = Footnotes.template('forms/newQuestionFormTemplate').render(@context())
    @$el.html(form)

  delete: (event) ->
    event.preventDefault()
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
    createdAt: new Date(@model.get("createdAt"))
    creatorID: @model.get("creatorID")
    createdAtPretty: @model.get("createdAtPretty")
    noteType: @model.get("noteType")


  close: (event)->
    event.preventDefault()
    @render()

  submit: (event) ->
    event.preventDefault()
    data = Footnotes.formToObj @$('form')
    @model.save data
    @close()   