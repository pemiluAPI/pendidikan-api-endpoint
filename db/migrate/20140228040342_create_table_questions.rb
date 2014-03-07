class CreateTableQuestions < ActiveRecord::Migration
  def change
    create_table :questions, :id => false, :primary_key => :id  do |t|
      t.string :id, :null => false, :limit => 25
      t.text :question
      t.text :answer
    end
  end
end
