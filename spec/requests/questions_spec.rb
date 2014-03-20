require 'spec_helper'

describe Pertanyaan::API do
  before (:each) do
    #two questions
    create(:question)
    create(:question, :id => '002')

    #one tag
    create(:tag)
  end

  describe "GET /api/pertanyaan" do
    it "returns an json of questions" do
      get "/api/pertanyaan"
      response.status.should == 200
      questions = Question.find_all
      response.body.should ==
        {
        results: {
          count: Question.count,
          total: questions.count,
          questions: questions
        }
      }.to_json
    end

    it "limit questions should works" do
      get "/api/pertanyaan?limit=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 1
      ress["results"]["total"].should == 2
    end

    it "offset questions should works" do
      get "/api/pertanyaan?limit=10&offset=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 1
      ress["results"]["total"].should == 2
      ress["results"]["questions"][0]['id'].should == "002"
    end

    it "seacrh by tags questions should works" do
      get "/api/pertanyaan?tags=TPS"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 1
      ress["results"]["total"].should == 1
    end

    it "should total return 0 if tag is not found" do
      get "/api/pertanyaan?tags=whatever"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 0
      ress["results"]["total"].should == 0
    end

  end

  describe "GET /api/pertanyaan/001" do
    it "returns an array of question" do
      get "/api/pertanyaan/001"
      response.status.should == 200
      response.body.should == {
        results: {
          count: 1,
          total: 1,
          questions: [{:id=>'001',
            :question => 'Dimana sih pemilu dilaksanain?',
            :answer => 'TPS',
            :tags => ["TPS"]
          }]
        }
      }.to_json
    end
  end

  describe "GET /api/tags/" do
    it "returns an array of tags" do
      get "/api/tags"
      response.status.should == 200
      response.body.should == {
          results: {
            count: 1,
            tags: [{:tag => "TPS", :question_count=>1}]
          }
        }.to_json
    end
  end
end