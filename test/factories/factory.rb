FactoryGirl.define do
  factory :article do
    sequence(:title) do |n|
      "title#{n}"
    end
    sequence(:description) do |n|
      "description#{n}"
    end
  end
end
