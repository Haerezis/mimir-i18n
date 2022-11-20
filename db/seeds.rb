# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.create(
  email: "demo@test.com",
  firstname: "Foo",
  lastname: "Bar",
  password: "azerty"
)
admin.skip_confirmation!
admin.save!

project = Project.factory_create(admin, "Test", ["en", "fr"])

project.translations.create(locale: "en", key: "foo.bar", value: "Hello World")
project.translations.create(locale: "fr", key: "foo.bar", value: "Bonjour monde")
project.translations.create(locale: "en", key: "foo.baz", value: "Hello Universe")
project.translations.create(locale: "fr", key: "foo.baz", value: "Bonjour univers")
