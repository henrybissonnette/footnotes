Footnotes.Views.QuestionView = class QuestionView extends Backbone.View
  
  tagName: 'div'

  className: 'footnote'

  events: 
    'click a' : 'onLinkClick'
    'click .minimize' : 'onToggleView'
    'click .edit' : 'edit'
    'click .close' : 'onClose'
    'click .delete' : 'delete'
    'submit form': 'submit'
    'click': 'viewFootnote'

  initialize: ->
    @model.bind("change",@render,@)
    @model.bind("destroy", @clear,@)
    @$el.addClass @model.get('noteType')
    @$el.attr('id',"#{@model.get("noteType")}#{@model.get("id")}")
 
  render: ->
    @$el.html Footnotes.template('notes/questionTemplate').render(@context())
    return this

  onToggleView: (event) ->
    event.stopPropagation()
    others = @$el.find('.title').siblings()
    typeIndicator = @$(".type_indicator")
    typeIndicator.remove()
    others.each ->
      if $(this).is(":visible")
        $(this).siblings(".title").find('.minimize').text('+')
        $(this).siblings(".title").addClass('minimized')
        $(this).siblings(".title").prepend(typeIndicator)
        $(this).hide()
      else
        $(this).siblings(".title").find('.minimize').text('-')
        $(this).siblings(".title").removeClass('minimized')
        $(this).siblings(".content").prepend(typeIndicator)
        $(this).show()

  edit: ->
    form = Footnotes.template('forms/questionFormTemplate').render(@context())
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
    canEdit: Footnotes.currentUser.get('username') == @model.get('creatorName')
    content: @model.get("content")
    id: @model.get("id")
    createdAt: new Date(@model.get("createdAt"))
    creatorID: @model.get("creatorID")
    createdAtPretty: @model.get("createdAtPretty")
    noteType: @model.get("noteType")
    descendantCount: @model.get("descendantCount")

  onClose: (event) ->
    event.preventDefault()
    @close()

  close: (event)->   
    @render()

  submit: (event) ->
    event.preventDefault()
    data = Footnotes.formToObj @$('form')
    @model.save data
    @close()  

  viewFootnote: ->
     @$el.trigger 
       type: 'viewFootnote'
       model: @model

  onLinkClick: (event) ->
    event.stopPropagation()