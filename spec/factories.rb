FactoryGirl.define do
  factory :question do
    id '001'
    question 'Dimana sih pemilu dilaksanain?'
    answer 'TPS'
  end

  factory :tag do
    id_question '001'
    tag 'TPS'
  end

  
end