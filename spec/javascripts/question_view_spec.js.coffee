# 
describe "Footnotes.Views.QuestionView", ->
  beforeEach ->
    @model = new Footnotes.Models.Question
      title: "test title"
      creatorName: "test creator"
      content: "test content"
      id: 5
      createdAt: "10/2/12"
      creatorID: 50
    Footnotes.Overlay.currentUser = new Footnotes.Models.User
      username: "test creator"
      id: 50

  describe "render", ->
    beforeEach ->
      @view = new Footnotes.Views.QuestionView
        model: @model
      @question = $(@view.render().el)  

    it "displays title", ->  
      expect(@question.find('.title').html()).toContain "test title"

    it "displays content", ->  
      expect(@question.find('.content').html()).toContain "test content"

    it "displays user link when model has userID", ->  
      expect(@question.find('a').html()).toBe @model.get('creatorName')

    it "doesnt display a link when the model has no userID", ->
      @model.set('creatorID',undefined)
      view = new Footnotes.Views.QuestionView
        model: @model
      question = $(view.render().el)
      expect(question.find('a').html()).toBeNull()
      @model.set('creatorID',50)

    it "dislays an edit button when the current user matches the creator", ->
      expect(@question.find('button').html()).toBe "edit"

    it "doesnt dislay an edit button when the current user doesnt match the creator", ->
      Footnotes.Overlay.currentUser.set
        username: "different"
        id: 75   
      question = $(@view.render().el)    
      expect(question.find('button').html()).toBeNull()
      Footnotes.Overlay.currentUser.set
        username: "test creator"
        id: 50  
    
  describe "toggleView", ->
    beforeEach ->
      @view = new Footnotes.Views.QuestionView
        model: @model

    # describe "from maximized, on title click", ->
    #   it "minimizes (all non title content is hidden)"
