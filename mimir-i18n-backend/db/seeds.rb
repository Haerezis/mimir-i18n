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
admin.save!

project = Project.factory_create(admin, "Test", ["en", "fr"])

key1 = project.translations.create(key: "foo.bar")
key2 = project.translations.create(key: "foo.baz")

key1.values.create(locale: "en", value: "Hello World")
key1.values.create(locale: "fr", value: "Bonjour monde")
key2.values.create(locale: "en", value: "Hello Universe")
key2.values.create(locale: "fr", value: "Bonjour univers")
