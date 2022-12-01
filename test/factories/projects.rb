FactoryBot.define do
  factory :project do
    name { "Test" }

    transient do
      owner { FactoryBot.create(:user) }
      locales { ['en', 'fr'] }
    end

    after(:create) do |project, evaluator|
      project.permissions.create(user: evaluator.owner, admin: true)

      evaluator.locales.each do |locale|
        project.locales.create(code: locale)
      end

      project.translations.create(locale: "en", key: "foo.bar", value: "Hello World")
      project.translations.create(locale: "fr", key: "foo.bar", value: "Bonjour monde")
      project.translations.create(locale: "en", key: "foo.baz", value: "Hello Universe")
      project.translations.create(locale: "fr", key: "foo.baz", value: "Bonjour univers")
    end
  end
end
