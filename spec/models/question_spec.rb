require 'spec_helper'

describe Question do
  before (:each) do
    @question = create(:question)
    @tag = create(:tag)
  end

  it "should has_many to a tags" do
    g = Question.reflect_on_association(:tags)
    g.macro.should == :has_many
  end

  it "should return details question" do
    @question.details.should == question_details
  end

  it "should return questions" do
     create(:question, id: "002")
     Question.find_all.count == 2
  end

  it "should return array" do
     Question.find_all.class.should == Array
  end

  it "should return interger for total" do
     Question.get_total.class.should == Fixnum
  end


  it "should return nil if no params tags" do
     Question.send(:conditions).should be_nil
  end

  it "should return array if isset params tags" do
     Question.send(:conditions, {:tags => "test"}).should == ["tags.tag = ?", "test"]
  end

  it "should return array if params tags is multiple" do
     Question.send(:conditions, {:tags => "test, test2"}).should == ["tags.tag in (?)", ["test", " test2"]]
  end

  def question_details
    {
      id: "001",
      question: "Dimana sih pemilu dilaksanain?",
      answer: "TPS",
      tags: ["TPS"]
    }
  end
end