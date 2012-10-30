 Footnotes.Collections.Questions = Backbone.Collection.extend
  model: Footnotes.Models.Question

  url: ->
    '/question_notes' + location.search

  initialize: (models, options) ->
    if options
      @parent = options[0].parent
    @on('add', @onAdd, @)
    @on('reset', @onReset, @)

  onAdd: ->
    @setParent()

  onReset: ->
    @setParent()

  setParent: ->
    @each (model) =>
      model.set('parent', @parent)

  comparator: (questionA,questionB) ->
    a = questionA.get("createdAt")
    b = questionB.get("createdAt")
    value = 1 if a > b
    value = -1 if a < b
    value = 0 if a == b
    -value       