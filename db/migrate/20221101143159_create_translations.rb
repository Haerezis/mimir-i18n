class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.references :translation_key, foreign_key: true
      t.references :project_locale, foreign_key: true

      t.text :value

      t.timestamps

      t.index [:translation_key_id, :project_locale_id], unique: true
    end
  end
end
