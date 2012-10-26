Footnotes.Models.Question = class Question extends Backbone.Model
  defaults:
    title: ''
    content: 'content'
    noteType: 'noType'
    creatorName: 'anonymous'
    canEdit: false

  events:
    'error': 'alert'

  urlRoot:
    '/question_notes'

