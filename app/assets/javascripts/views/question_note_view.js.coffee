window.footnotes.QuestionNoteView = class QuestionNoteView extends Backbone.View
  el: ".right_bar .contents"

  initialize: (questionNote) ->
    @note  = questionNote

  render: ->
    #@$el.append @template(@note.toJSON())
    @$el.append HoganTemplates['notes/QuestionView'].render(@note.toJSON())

