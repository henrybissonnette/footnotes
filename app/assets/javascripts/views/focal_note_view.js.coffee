Footnotes.Views.FocalNoteView = Backbone.View.extend
  
  tagName: 'div'

  className: 'footnote'

  initialize: ->
    @$el.addClass("#{@model.get("noteType")}")
    @$el.attr('id',"#{@model.get("noteType")}#{@model.get("id")}")

  render: ->
    @$el.html Footnotes.template('notes/staticQuestionTemplate').render(@context())
    return this

  context: ->
    title: @model.get("title")
    creatorName: @model.get("creatorName")
    canEdit: Footnotes.currentUser.get('username') == @model.get('creatorName')
    content: @model.get("content")
    id: @model.get("id")
    createdAt: @model.get("createdAt")
    creatorID: @model.get("creatorID")
    createdAtPretty: @model.get("createdAtPretty")
    noteType: @model.get("noteType")
