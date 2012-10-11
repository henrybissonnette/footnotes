window.Footnotes.Views.QuestionView = class QuestionView extends Backbone.View
  
  tagName: 'div'

  className: 'footnote'  

  render: ->
    @$el.append Footnotes.template('notes/QuestionView').render(@model.toJSON())
    return this
