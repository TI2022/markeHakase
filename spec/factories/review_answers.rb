FactoryBot.define do
  factory :review_answer do
    staff { nil }
    review { nil }
    staff_name { "MyString" }
    content { "MyText" }
  end
end
