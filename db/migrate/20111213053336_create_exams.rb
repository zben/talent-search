class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.integer :user_id
      t.string :exam_name
      t.integer :score
      t.date :date
      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
