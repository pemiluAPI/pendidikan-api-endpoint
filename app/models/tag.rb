class Tag < ActiveRecord::Base
  belongs_to :question, foreign_key: :id_question

  def self.find_all
    tags = Array.new
    Tag.group('tag').count.each do |field|
      tags << {
        tag: field[0],
        question_count: field[1]
      }
    end
    tags
  end
end
