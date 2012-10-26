 Footnotes.Collections.Questions = Backbone.Collection.extend
  url: ->
    '/question_notes' + location.search

  model: Footnotes.Models.Question

  comparator: (questionA,questionB) ->
    a = questionA.get("createdAt")
    b = questionB.get("createdAt")
    value = 1 if a > b
    value = -1 if a < b
    value = 0 if a == b
    -value       