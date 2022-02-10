FactoryBot.define do
  factory :reservation do
    start_time { Time.current.tomorrow }
    course { "10" }
    comment { "sample" }
    association :guest, factory: :user
    association :staff, factory: :staff
  end
end
