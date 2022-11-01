class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.timestamps

      t.references :project, foreign_key: true
      t.references :project_locale, foreign_key: true

      t.string :key
      t.text :value

      t.index [:project_id, :project_locale_id, :key], unique: true
    end
  end
end
