class Question < ActiveRecord::Base
  self.primary_key  = "id"
  has_many :tags, foreign_key: :id_question

  def self.find_all(params = Hash.new())
    questions= Array.new
    conditions = ((params[:tags].include?(',')) ? ["tags.tag in (?)", params[:tags].gsub('_', ' ').split(',')] : ["tags.tag = ?", "#{params[:tags].gsub('_', ' ')}"]) if !params[:tags].blank?
    Question.includes(:tags).where(conditions).limit(params[:limit]).offset(params[:offset]).references(:tags).each do |field|
      questions << field.details
    end
    questions
  end

  def details
    {
      id: self.id,
      question: self.question,
      answer: self.answer,
      tags: self.tags.map { |tag| tag.tag }
    }
  end
  
  
end
