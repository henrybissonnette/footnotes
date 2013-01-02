Footnotes.Views.NoteFocusView = Backbone.View.extend

  events:
    'click .goUp': 'onGoUp'
    'click .focus': 'onGoUp'
    'click a': 'onLinkClick'

  initialize: ->
    @collection.on 'change', @renderChildren, @

  render: ->
    @$el.html Footnotes.template('noteFocusTemplate').render()
    @focus = new Footnotes.Views.FocalNoteView
      model: @model
    @form = new Footnotes.Views.ResponseFormView
      parent: @model
      collection: @collection
    @renderChildren()
    @$el.find('.focus').html @focus.render().el
    @$el.find('.form').html @form.render().el
    return this

  renderChildren: ->
    @children = new Footnotes.Views.NoteListView
      collection: @collection
      focus: @model
    @$el.find('.children').html @children.render().el

  onGoUp: ->
    @$el.trigger 
      type: 'viewFootnote'
      model: @collection.getParent(@model)

  onLinkClick: (event) ->
    event.stopPropagation()