describe "Footnotes.Models.Question", ->
  beforeEach ->
    @collection = new Footnotes.Collections.Questions
    
  describe "comparator", ->
    beforeEach ->
      @now = new Date()
      @later = new Date()
      @later.setMinutes(@later.getMinutes()+1)

    it "sorts the collection such that the newest question is always at the beginning.", ->
      question = new Footnotes.Models.Question
        title: 'a'
        createdAt: @now
      @collection.add question
      question = new Footnotes.Models.Question
        title: 'b'
        createdAt: @later
      @collection.add question      
      titleArray = @collection.pluck("title")
      expect(titleArray[0]).toBe 'b'

    it "sorts the collection such that the newest question is always at the beginning.", ->
      question = new Footnotes.Models.Question
        title: 'a'
        createdAt: @later
      @collection.add question
      question = new Footnotes.Models.Question
        title: 'b'
        createdAt: @now
      @collection.add question      
      titleArray = @collection.pluck("title")
      expect(titleArray[0]).toBe 'a'


  

