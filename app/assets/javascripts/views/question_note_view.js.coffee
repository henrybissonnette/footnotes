window.footnotes.QuestionNoteView = class QuestionNoteView extends Backbone.View
  el: ".right_bar .contents"

  template: _.template """
<div class="title <%= id + " " + type %>">
  <%= title %>
</div>

<div class="info">
  <span class="author">
    <%= authorName %>
  </span>
</div>

<div class="content">
  <%= content %>
</div>
  """

  initialize: (questionNote) ->
    @note  = questionNote

  render: ->
    @$el.append @template(@note.toJSON())

