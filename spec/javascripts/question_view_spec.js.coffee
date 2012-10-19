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
    @view = new Footnotes.Views.QuestionView
      model: @model
    @question = $(@view.render().el) 

  describe "render", ->
    it "displays title", ->  
      titleText = @question.find('.title').text()
      expect(titleText).toContain @model.get('title')

    it "displays content", ->  
      expect(@question.find('.content').html()).toContain @model.get('content')

    it "displays user link when model has userID", ->  
      expect(@question.find('a.toCreatorPage').length).toBe 1

    it "doesnt display a link to creator's page when the model has no userID", ->
      @model.set('creatorID',undefined)
      view = new Footnotes.Views.QuestionView
        model: @model
      question = $(view.render().el)
      expect(question.find('a.toCreatorPage').length).toBe 0

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
    describe "from maximized, on title click", ->
      it "minimizes (all non title content is hidden)", ->
        $('body').append(@question)
        @question.find(".title").click()
        expect(@question.find('.content').is(':visible')).toBe false
        @question.remove()

  describe "edit", ->
    it "displays an edit form when the edit button is clicked", ->
      @question.find('.edit').click()
      expect(@question.find('form').length).toBeGreaterThan 0

  describe "delete", ->
    it "calls destroy when clicked", ->
      spyOn(@model,'destroy')
      spyOn(window,'confirm').andReturn true
      @question.find('.edit').click()
      @question.find('.delete').click()
      expect(@model.destroy).toHaveBeenCalled()

  # describe "clear", ->
  #   it "removes the question from the page when delete is clicked", ->
  #     spyOn(@model,'destroy')
  #     spyOn(window,'confirm').andReturn true
  #     # page = $('<div>')
  #     # page.append @question
  #     $('body').append @question
  #     @question.find('.edit').click()
  #     @question.find('.delete').click()
  #     expect($('.footnote').length).toBe 0

  describe "close", ->
    beforeEach ->
      @question.find('.edit').click()
      @question.find('.close').click()
    it "displays the question", ->
      expect(@question.find('.content').html()).toContain @model.get('content')
    it "is no longer displaying the form", ->
      expect(@question.find('form').length).toBe 0

  # describe "submit", ->
  #   beforeEach ->
  #     spyOn(@model,'save')
  #     @question.find('.edit').click()
  #     @question.find('input[type="submit"]').click()
  #   it 'saves the model', ->
  #     expect(@model.save).toHaveBeenCalled()
  #   it 'displays the question', ->
  #     expect(@question.find('.content').html()).toContain @model.get('content')
