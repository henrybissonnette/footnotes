Footnotes.Views.NoteFocusView = Backbone.View.extend

  events:
    'click .goUp': 'onGoUp'
    'click .focus': 'onGoUp'
    'click a': 'onLinkClick'

  render: ->
    @$el.html Footnotes.template('noteFocusTemplate').render()
    @focus = new Footnotes.Views.FocalNoteView
      model: @model
    @form = new Footnotes.Views.ResponseFormView
      parent: @model
    @children = new Footnotes.Views.NoteListView
      collection: @model.get 'children'
    @$el.find('.children').html @children.render().el
    @$el.find('.focus').html @focus.render().el
    @$el.find('.form').html @form.render().el
    return this

  onGoUp: ->
    @$el.trigger 
      type: 'viewFootnote'
      model: @model.get('parent')

  onLinkClick: (event) ->
    event.stopPropagation()