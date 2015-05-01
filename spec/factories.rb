FactoryGirl.define do

  factory :task do
    sequence(:title) { |n| "ToDo #{n}" }
  end
end