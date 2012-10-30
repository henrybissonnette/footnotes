Footnotes.Models.Question = class Question extends Backbone.Model

  initialize: ->
    raw = @get('children')
    @set 'children', new Footnotes.Collections.Questions(raw,[{parent: @}])
    @get('children').trigger('reset')

  events:
    'error': 'alert'

  urlRoot:
    '/question_notes'

  parse: (response) ->
    response.children = new Footnotes.Collections.Questions response.children
    return response

