FactoryGirl.define do

  factory :task do
    sequence(:title) { |n| "Task number #{n}" }
    content { Faker::Lorem.paragraphs(2).to_s }
    status { [:Open, :Close].sample }
  end
end