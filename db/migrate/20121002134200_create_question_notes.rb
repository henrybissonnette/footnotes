class CreateQuestionNotes < ActiveRecord::Migration
  def change
    create_table :question_notes do |t|
      t.string :content

      t.timestamps
    end
  end
end
