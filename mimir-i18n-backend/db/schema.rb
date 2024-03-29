# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_23_204927) do
  create_table "access_keys", force: :cascade do |t|
    t.integer "project_id"
    t.string "name", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "value"], name: "index_access_keys_on_project_id_and_value", unique: true
    t.index ["project_id"], name: "index_access_keys_on_project_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "project_locales", force: :cascade do |t|
    t.string "code", null: false
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_locales_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "releases", force: :cascade do |t|
    t.integer "project_id"
    t.string "sha"
    t.text "message", null: false
    t.text "export_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_releases_on_project_id"
  end

  create_table "translation_keys", force: :cascade do |t|
    t.integer "project_id"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "key"], name: "index_translation_keys_on_project_id_and_key", unique: true
    t.index ["project_id"], name: "index_translation_keys_on_project_id"
  end

  create_table "translation_values", force: :cascade do |t|
    t.integer "translation_key_id"
    t.text "locale"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_key_id", "locale"], name: "index_translation_values_on_translation_key_id_and_locale", unique: true
    t.index ["translation_key_id"], name: "index_translation_values_on_translation_key_id"
  end

  create_table "user_project_permissions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.boolean "readonly", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_project_permissions_on_project_id"
    t.index ["user_id"], name: "index_user_project_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_keys", "projects"
  add_foreign_key "project_locales", "projects"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "releases", "projects"
  add_foreign_key "translation_keys", "projects"
  add_foreign_key "translation_values", "translation_keys"
  add_foreign_key "user_project_permissions", "projects"
  add_foreign_key "user_project_permissions", "users"
end
