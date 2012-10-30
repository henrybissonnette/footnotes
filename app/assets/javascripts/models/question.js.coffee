Footnotes.Models.Question = class Question extends Backbone.Model

  initialize: ->
    @.set('children', new Footnotes.Collections.Questions())

  events:
    'error': 'alert'

  urlRoot:
    '/question_notes'

  parse: (response) ->
    response.children = new Footnotes.Collections.Questions response.children
    return response

