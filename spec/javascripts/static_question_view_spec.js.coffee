describe "Footnotes.Views.staticQuestionView", ->
  beforeEach ->
    @model = new Footnotes.Models.Question
      title: 'test title'
      content: 'test content'
      id: 50   
      creatorName: 'hank'
      creatorID: 1
      createdAtPretty: 'pretty date string'
      noteType: 'Question'
      externalURL: 'www.subject.com'

    @view = new Footnotes.Views.staticQuestionView
      model: @model

  describe "rendered question", ->
    beforeEach ->
      @$el = $(@view.render().el)

    it "displays title", ->  
      titleText = @$el.find('.title').text()
      expect(titleText).toContain @model.get('title')

    it "displays content", ->  
      contentText = @$el.find('.content').text()
      expect(contentText).toContain @model.get('content')

    it "has id equal to note_idnote_type", ->
      expect(@$el.attr('id')).toBe "#{@model.get("noteType")}#{@model.get("id")}"

    it "has a class equal to the model's type", ->
      expect(@$el.hasClass(@model.get('noteType'))).toBe true

    it "has the class footnote", ->
      expect(@$el.hasClass('footnote')).toBe true

    it "displays a link to the creator's page when model has userID", ->  
      expect(@$el.find('a.toCreatorPage').length).toBe 1

    it "doesn't display a link to creator's page when the model has no userID", ->
      @model.set('creatorID',undefined)
      view = new Footnotes.Views.staticQuestionView
        model: @model
      @$el = $(view.render().el)
      expect(@$el.find('a.toCreatorPage').length).toBe 0

    describe "when any part of the static question is clicked", ->
      it "loads the window with the question's source overlay", ->
        spyOn(location,'replace')
        @$el.click()
        expect(location.replace).toHaveBeenCalledWith @model.get(externalURL)




