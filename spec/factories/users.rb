FactoryBot.define do
  factory :user do
    name { "guest" }
    email { "guest@email.com" }
    password { "password" }
    password_confirmation { "password" }
    phone { "090-0000-0000" }
    association :store
  end
end
