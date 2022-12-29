FactoryBot.define do
  factory :project do
    name { "Test" }

    owner { FactoryBot.create(:user) }

    transient do
      locales { ['en', 'fr'] }
    end

    after(:create) do |project, evaluator|
      evaluator.locales.each do |locale|
        project.locales.create(code: locale)
      end

      key1 = project.translations.create(key: "foo.bar")
      key2 = project.translations.create(key: "foo.baz")

      key1.values.create(locale: "en", value: "Hello World")
      key1.values.create(locale: "fr", value: "Bonjour monde")
      key2.values.create(locale: "en", value: "Hello Universe")
      key2.values.create(locale: "fr", value: "Bonjour univers")
    end
  end
end
