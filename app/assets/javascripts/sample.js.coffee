
# $ ->
#   class Example extends Backbone.View
#     el: $('#example')

#     initialize: ->
#       @.addClass('clickable')

#     events:
#       'click :p': 'onPClick'

#     onPClick: ->
#       @$('p').text('Hello World!')

#   window.Example = class Example extends Backbone.View
#     el: $('#example')

#     initialize: ->
#       @$('p').addClass('clickable')
#       qNote = new window.footnotes.QuestionNoteModel
#       noteView = new window.footnotes.QuestionNoteView(qNote)
#       noteView.render()

#     events:
#       'click': 'onPClick'

#     onPClick: ->
#       if @$('p').text() == 'Hello World!'
#         @$('p').text('Click me!')
#       else
#         @$('p').text('Hello World!')


#   example = new Example