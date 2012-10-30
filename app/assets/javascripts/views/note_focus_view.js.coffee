Footnotes.Views.NoteFocusView = Backbone.View.extend

  events:
    'click .goUp': 'onGoUp'
    'viewFootnote .footnote': 'onViewFootnote'

  initialize: (options) ->
    @parentList  = options.parentList || []

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
    if @parentList.length > 0
      parent = @parentList.pop()
      @$el.trigger 
        type: 'viewFootnote'
        model: parent
        parentList: @parentList
    else
      @$el.trigger 'viewAll'

  onViewFootnote: (event) ->
    event.stopPropagation()
    @parentList.push @model
    @$el.trigger
      type: 'viewFootnote'
      model: event.model
      parentList: @parentList