FactoryBot.define do
  factory :staff do
    name { "staff" }
    email { "staff@email.com" }
    password { "password" }
    password_confirmation { "password" }
    phone { "090-0000-0000" }
    association :store
  end
end
