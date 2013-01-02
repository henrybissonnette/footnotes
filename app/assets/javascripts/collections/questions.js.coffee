 Footnotes.Collections.Questions = Backbone.Collection.extend
  model: Footnotes.Models.Question

  url: ->
    '/question_notes' + location.search

  getParent: (model) ->
    @where({id: model.get('parentID')})[0]

  getByID: (id) ->
    @where({id: id})[0]

  getChildren: (model) ->
    new Footnotes.Collections.Questions @where({parentID: model.id})

  getTopNotes: ->
    new Footnotes.Collections.Questions @where({parentID: null})

  comparator: (questionA,questionB) ->
    a = questionA.get("createdAt")
    b = questionB.get("createdAt")
    value = 1 if a > b
    value = -1 if a < b
    value = 0 if a == b
    -value       