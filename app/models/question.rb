class Question < ActiveRecord::Base
  self.primary_key  = "id"
  has_many :tags, foreign_key: :id_question

  def self.find_all(params = Hash.new)
    questions= Array.new
    Question.includes(:tags).where(self.conditions(params)).limit(params[:limit]).offset(params[:offset]).references(:tags).each do |field|
      questions << field.details
    end
    questions
  end

  def self.get_total(params = Hash.new)
    Question.includes(:tags).where(self.conditions(params)).references(:tags).count
  end

  def details
    {
      id: self.id,
      question: self.question,
      answer: self.answer,
      tags: self.tags.map { |tag| tag.tag }
    }
  end

  private
  def self.conditions(params = Hash.new)
    conditions = ((params[:tags].include?(',')) ? ["tags.tag in (?)", params[:tags].gsub('_', ' ').split(',')] : ["tags.tag = ?", "#{params[:tags].gsub('_', ' ')}"]) if !params[:tags].blank?
  end
end