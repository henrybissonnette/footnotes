describe "Footnotes.Views.NewQuestionFormView", ->
  beforeEach ->
    @questions = new Footnotes.Collections.Questions
    @questions.add 
      content: 'question content'
      title: 'question title'
      subjectURL: 'www.google.com'
      createdAt: (new Date).toISOString()
    @newForm = new Footnotes.Views.NewQuestionFormView
      questions: @questions
    @newFormObject = $(@newForm.render().el)

  describe "render", ->
    it "initially displays an open button", -> 
      expect(@newFormObject.find('button').hasClass('open')).toBe true

    it "does not initially display a form", ->
      expect(@newFormObject.find('form').length).toBe 0

  # describe "closeForm", ->
  #   describe "when the form has been opened and then the close button is clicked", ->
  #     beforeEach ->
  #       @newFormObject.find('.open').click()
  #       @newFormObject.find('.close').click()
  #     it "displays an open button", -> 
  #       expect(@newFormObject.find('button').hasClass('open')).toBe true

  #     it "does not display a form", ->
  #       expect(@newFormObject.find('form').length).toBe 0


  describe "openForm", ->
    beforeEach ->
      @newFormObject.find('.open').click()

    it "displays a form", ->  
      expect(@newFormObject.find('form').length).toBe 1

    it "does not display an open button", ->
      expect(@newFormObject.find('button.open').length).toBe 0

    it "creates an text area with the name 'content'", ->
      expect(@newFormObject.find('textarea[name="content"]').length).toBe 1

    it "creates an input with the name 'title'", ->
      expect(@newFormObject.find('input[name="title"]').length).toBe 1

    it "creates an input of type submit", ->
      expect(@newFormObject.find('input[type="submit"]').length).toBe 1

    it "displays a cancel button", ->
      expect(@newFormObject.find('button.close').length).toBe 1

  # describe "submit", ->
  #   beforeEach ->
  #     @newFormObject.find('.open').click()
  #     form = @newFormObject.find('form')
  #     form.find('input[name="title"]').val() = "test title"
  #     form.find('input[name="content"]').val() = "test content"
  #     spyOn(@questions, 'create')

  #   it "calls create with the form data in an object", ->
  #     #is there a way to get the data a spy was called with?



