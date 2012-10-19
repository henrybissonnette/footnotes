class LengthenQuestionContent < ActiveRecord::Migration
  def up
    change_table :question_notes do |t|
      t.change :content, :text   
    end
  end

  def down
    change_table :question_notes do |t|
      t.change :content, :string  
    end
  end
end
