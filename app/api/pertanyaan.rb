module Pertanyaan
  class API < Grape::API
    prefix 'api'
    format :json

    resource :pertanyaan do
      desc "Return all data question."
      get do
        questions = Question.find_all(params)
        {
          results: {
            count: questions.count,
            total: Question.get_total(params),
            questions: questions
          }
        }
      end

      desc "Return a question"
      params do
        requires :id, type: String, desc: "Question ID."
      end
      route_param :id do
        get do
          question = Question.find_by(id: params[:id])
          question_detail = [question.details] rescue nil
          {
            results: {
              count: (question_detail) ? 1 : 0,
              total: (question_detail) ? 1 : 0,
              questions: question_detail
            }
          }
        end
      end
    end

    resource :tags do
      desc "Return all tags."
      get do
        tags = Tag.find_all
        {
          results: {
            count: tags.count,
            tags: tags
          }
        }
      end
    end

    
  end
end