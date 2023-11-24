FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'Password' }
  end

  factory :food do
    name { 'Example Food' }
    measurement_unit { 'kg' }
    price { 10.99 }
    quantity { 1 }
    user
  end
end
