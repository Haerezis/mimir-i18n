FactoryBot.define do
  factory :user do
    email
    firstname { "Foo" }
    lastname { "Bar" }
    password { "azerty" }

    after(:create) do |user, evaluator|
      user.skip_confirmation!
      user.save
    end
  end
end
