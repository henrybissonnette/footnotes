window.Footnotes.Views.staticQuestionView = class StaticQuestionView extends Backbone.View
  
  tagName: 'div'

  className: 'footnote clickable'

  events:
    'click':'redirect'

  render: ->
    @$el.html Footnotes.template('notes/staticQuestionTemplate').render(@context())
    return this

  context: ->
    title: @model.get("title")
    creatorName: @model.get("creatorName")
    canEdit: Footnotes.Home.currentUser.get('username') == @model.get('creatorName')
    content: @model.get("content")
    id: @model.get("id")
    createdAt: @model.get("createdAt")
    creatorID: @model.get("creatorID")
    createdAtPretty: @model.get("createdAtPretty")
    
  redirect: ->
    window.location.replace("/overlay?external_url=#{@model.get("externalURL")}")