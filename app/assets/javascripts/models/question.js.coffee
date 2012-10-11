window.Footnotes.Models.Question = class Question extends Backbone.Model
  defaults:
    title: "No Title... Bwaaa?"
    content: "This note has not content!?"
    authorName: "Unknown Author"
    type: "question"

  urlRoot:
    '/question_notes'

Footnotes.Collections.Questions = Backbone.Collection.extend
  url: ->
    '/footnotes/get' + location.search

  model: Footnotes.Models.Question

  parse: (data) ->
    alert data
    data