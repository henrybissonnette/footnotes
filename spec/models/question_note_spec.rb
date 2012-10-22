require 'spec_helper'

describe QuestionNote do
  before do
    @q = QuestionNote.new    
  end
  it "automatically generates an associated MetaNote" do
    @q.meta.class.should be(MetaNote)
  end

  it "validates existence of subject url through meta" do
    @q.should_not be_valid
  end

  it "validates existence of subject url through meta" do
    @q.subject_url = 'www.hank.com'
    @q.should be_valid
  end
end
