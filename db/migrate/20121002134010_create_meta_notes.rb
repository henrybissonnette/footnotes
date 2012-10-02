class CreateMetaNotes < ActiveRecord::Migration
  def change
    create_table :meta_notes do |t|
      t.string :title
      t.integer :creator_id
      t.integer :parent_id
      t.string :subject_url
      t.integer :note_id
      t.string :note_type

      t.timestamps
    end
  end
end
