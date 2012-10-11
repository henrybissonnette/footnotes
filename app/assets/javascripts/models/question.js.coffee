window.Footnotes.Models.Question = class Question extends Backbone.Model
  defaults:
    title: "No Title... Bwaaa?"
    content: "This note has not content!?"
    authorName: "Unknown Author"
    type: "question"

  urlRoot:
    '/questionNote'

Footnotes.Collections.Questions = Backbone.Collection.extend
  model: Footnotes.Models.Question