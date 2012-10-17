task :tidyDB => :environment do
  meta = MetaNote.all
  meta.each do |m|
    if m.note_id
      if !m.note
        q = QuestionNote.find(m.note_id)
        m.note = q
        q.meta = m
        q.save
      end
    else
      m.destroy
    end
    if !m.subject_url
      m.destroy
    end
  end

  question = QuestionNote.all
  question.each do |q|
    if !q.meta
      q.destroy
    end
  end
end