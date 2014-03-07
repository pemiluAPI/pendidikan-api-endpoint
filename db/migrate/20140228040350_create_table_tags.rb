class CreateTableTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :id_question
      t.string :tag
    end
  end
end
