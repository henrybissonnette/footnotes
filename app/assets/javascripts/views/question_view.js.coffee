window.Footnotes.Views.QuestionView = class QuestionView extends Backbone.View
  
  tagName: 'div'

  className: 'footnote' 

  events: 
    'click .title' : 'toggleView'

  render: ->
    @$el.append Footnotes.template('notes/QuestionView').render(@model.toJSON())
    return this

  toggleView: ->
    others = @$el.find('.title').siblings()
    others.each ->
      if $(this).is(":visible")
        $(this).hide()
      else
        $(this).show()