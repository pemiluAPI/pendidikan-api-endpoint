require 'spec_helper'

describe Tag do
  before (:each) do
    @question = create(:question)
    @tag = create(:tag)
  end
  
  it "should belongs to a question" do
    g = Tag.reflect_on_association(:question)
    g.macro.should == :belongs_to
  end

  it "should return tags" do
     Tag.find_all.should == [{:tag=>"TPS", :question_count=>1}]
  end
end
