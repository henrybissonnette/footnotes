window.Footnotes.Models.Question = class Question extends Backbone.Model
  defaults:
    title: 'title'
    content: 'content'
    noteType: 'noType'
    creatorName: 'anonymous'
    canEdit: false


  urlRoot:
    '/question_notes'

Footnotes.Collections.Questions = Backbone.Collection.extend
  url: ->
    '/question_notes' + location.search

  model: Footnotes.Models.Question