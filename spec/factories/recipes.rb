FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Recipe #{n}" }
    preparation_time { 30 }
    cooking_time { 30 }
    description { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
    public { [true, false].sample }

    association :user, factory: :user
  end
end
